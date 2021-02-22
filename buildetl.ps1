function buildthem
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path
    )
    process
    {
        $msBuildExe="MSBuild"
        
        Write-Host "Cleaning $($path)" -foregroundcolor Yellow
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
    }
}

$EtlDirectory = "$PSScriptRoot\..\insights\etl\"
$migrationDirectory = "$PSScriptRoot\..\insights\API\Navex.Insights.Migrations\bin\Release\netcoreapp3.1"
Push-Location $EtlDirectory
Get-ChildItem $EtlDirectory -Recurse -Filter *.csproj | 
Foreach-Object {
  buildthem $_.FullName
}
Write-Host "running Migration" -foregroundcolor green
. $migrationDirectory\Navex.Insights.Migrations.exe

Write-Host "running SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1" -foregroundcolor green
Navex.Insights.Etl.SsisPackageBuilder\bin\Release\Navex.Insights.Etl.SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1 --PackageDirectory C:\code\insights\etl\Navex.Insights.Ssis

Pop-Location
