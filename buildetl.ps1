function buildthem
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path
    )
    process
    {
        $msBuildExe = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe'
        
        Write-Host "Cleaning $($path)" -foregroundcolor green
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
    }
}

$EtlDirectory = "$PSScriptRoot\..\insights\etl\"
Set-Location $EtlDirectory
Get-ChildItem $EtlDirectory -Recurse -Filter *.csproj | 
Foreach-Object {
  buildthem $_.FullName
}

Navex.Insights.Etl.Schema\bin\Debug\Navex.Insights.Etl.Schema.exe --SourceDb=cm_Test1 --SourceServer=. --RunStaging --StagingServer=. --StagingDb=Insights_Staging

Navex.Insights.Etl.SsisPackageBuilder\bin\Debug\Navex.Insights.Etl.SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1

