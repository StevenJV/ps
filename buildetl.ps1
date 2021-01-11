function buildthem
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path
    )
    process
    {
        $msBuildExe = "MSBuild"
        
        Write-Host "Cleaning $($path)" -foregroundcolor Yellow
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
    }
}

$EtlDirectory = "$PSScriptRoot\..\insights\etl\"
Push-Location $EtlDirectory
Get-ChildItem $EtlDirectory -Recurse -Filter *.csproj | 
Foreach-Object {
  buildthem $_.FullName
}
Write-Host "running Schema.exe --SourceDb=cm_Test1 --SourceServer=.  --StagingServer=. --StagingDb=Insights_Staging" -foregroundcolor green
Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_Test1 --SourceServer=. --StagingServer=. --StagingDb=Insights_Staging 

Write-Host "Schema.exe --SourceDb=cm_insightsqalocal1 --SourceServer=.  --StagingServer=. --StagingDb=Insights_Staging --AdminServer=. --AdminDb=Insights_Admin" -ForegroundColor green
Navex.Insights.Etl.Schema\bin\Release\Navex.Insights.Etl.Schema.exe --SourceDb=cm_insightsqalocal1 --SourceServer=. --StagingServer=. --StagingDb=Insights_Staging --AdminServer=. --AdminDb=Insights_Admin

Write-Host "running SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1" -foregroundcolor green
Navex.Insights.Etl.SsisPackageBuilder\bin\Release\Navex.Insights.Etl.SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1 --PackageDirectory C:\code\insights\etl\Navex.Insights.Ssis

Pop-Location
