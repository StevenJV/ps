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

Set-Location \code\insights\etl
$EtlDirectory = "C:\code\insights\etl\"
$SchemaPath = Join-Path -Path $EtlDirectory -ChildPath "Navex.Insights.Etl.Schema\Navex.Insights.Etl.Schema.csproj"
buildthem $SchemaPath
$PackageBuilderPath = Join-Path -Path $EtlDirectory -ChildPath "Navex.Insights.Etl.SsisPackageBuilder\Navex.Insights.Etl.SsisPackageBuilder.csproj"
buildthem $PackageBuilderPath
Navex.Insights.Etl.Schema\bin\Debug\Navex.Insights.Etl.Schema.exe --SourceDb=cm_Test1 --SourceServer=. --RunStaging
Navex.Insights.Etl.SsisPackageBuilder\bin\Debug\Navex.Insights.Etl.SsisPackageBuilder.exe --CustomerKey=test1 --SourceDb=cm_Test1
