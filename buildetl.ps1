function buildthem
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path
    )
    process
    {
        $msBuildExe = 'C:\Program Files (x86)\Microsoft Visual Studio\2019\BuildTools\MSBuild\Current\Bin\msbuild.exe'
        #$msBuildExe = MSBuild 
        
        Write-Host "Cleaning $($path)" -foregroundcolor Green
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
    }
}

$EtlDirectory = "$PSScriptRoot\..\insights\etl"
$InsightsDirectory =  "$PSScriptRoot\..\insights"
Push-Location $InsightsDirectory

Write-Host "building old etl, ssis" -foregroundcolor Yellow
Get-ChildItem $EtlDirectory -Recurse -Filter *.csproj |
Foreach-Object {
  buildthem $_.FullName
}

Write-Host "running Schema.exe --SourceDb=cm_Test1" -foregroundcolor green
. $EtlDirectory\Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_Test1

Write-Host "Schema.exe --SourceDb=cm_insightsqalocal1" -ForegroundColor green
. $EtlDirectory\Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_insightsqalocal1

Write-Host "Schema.exe --SourceDb=cm_tophat" -ForegroundColor green
. $EtlDirectory\Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_tophat --SourceServer=.

Write-Host "running Migration" -foregroundcolor green
. tools\PsScripts\runMigrations.ps1

Write-Host "running SsisPackageBuilder.exe to C:\Deploy\SsisPackages --CustomerKey=test1 --SourceDb=cm_Test1" -foregroundcolor green
. $ETLdirectory\Navex.Insights.Etl.SsisPackageBuilder\bin\Release\Navex.Insights.Etl.SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1 --PackageDirectory="C:\Deploy\SsisPackages"
