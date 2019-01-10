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
        
        Write-Host "Cleaning $($path)" -foregroundcolor Yellow
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
    }
}

buildthem('C:\code\insights\api\Navex.Insights.API.Core\Navex.Insights.API.Core.csproj')

Write-Host "stopping QueueConsumer" -foregroundcolor blue
# C:\code\insights\api\Navex.Insights.QueueConsumer\publish\Navex.Insights.QueueConsumer.exe stop
net stop navex.Insights.QueueConsumer
buildthem('C:\code\insights\api\Navex.Insights.QueueConsumer\Navex.Insights.QueueConsumer.csproj')
Write-Host "Publishing Navex.Insights.QueueConsumer.csproj" -foregroundcolor Blue
dotnet publish 'C:\code\insights\api\Navex.Insights.QueueConsumer\Navex.Insights.QueueConsumer.csproj' -c Release -r win10-x64 -o 'C:\code\insights\api\Navex.Insights.QueueConsumer\publish'
Write-Host "restarting QueueConsumer" -foregroundcolor blue
C:\code\insights\api\Navex.Insights.QueueConsumer\publish\Navex.Insights.QueueConsumer.exe start

buildthem('C:\code\insights\api\Navex.Insights.API\Navex.Insights.API.csproj')
iisreset /stop
Write-Host "Publishing Navex.Insights.API.csproj" -foregroundcolor Blue
dotnet publish 'C:\code\insights\api\Navex.Insights.API\Navex.Insights.API.csproj' --no-build -o 'C:\code\insights\api\Navex.Insights.API\publish\'
iisreset /start
