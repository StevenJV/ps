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
        
        Write-Host "Cleaning $($path)" -foregroundcolor Green
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
    }
}

$EtlDirectory = "$PSScriptRoot\..\insights\etl\"
$migrationDirectory = "$PSScriptRoot\..\insights\API\Navex.Insights.Migrations\bin\Release\netcoreapp3.1"

Push-Location $EtlDirectory

Write-Host "building old etl, ssis" -foregroundcolor Yellow
Get-ChildItem $EtlDirectory -Recurse -Filter *.csproj |
Foreach-Object {
  buildthem $_.FullName
}

Write-Host "building new migrator" -foregroundcolor Yellow
Push-Location $migrationDirectory
Get-ChildItem $migrationDirectory -Recurse -Filter *.csproj |
Foreach-Object {
  buildthem $_.FullName
}
Pop-Location

Write-Host "running Schema.exe --SourceDb=cm_Test1" -foregroundcolor green
Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_Test1

Write-Host "Schema.exe --SourceDb=cm_insightsqalocal1" -ForegroundColor green
Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_insightsqalocal1
Write-Host "running Migration" -foregroundcolor green
. $migrationDirectory\Navex.Insights.Migrations.exe

Write-Host "running SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1" -foregroundcolor green
Navex.Insights.Etl.SsisPackageBuilder\bin\Release\Navex.Insights.Etl.SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1 --PackageDirectory C:\code\insights\etl\Navex.Insights.Ssis

Pop-Location
