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
Write-Host "stopping QueueConsumer" -foregroundcolor blue
net stop navex.Insights.QueueConsumer
Write-Host "stopping IIS" -foregroundcolor blue
iisreset /stop
Write-Host "cleaning \logs\" -foregroundcolor blue
remove-item c:\logs\*.* -force 

$ApiDirectory = "$PSScriptRoot\..\insights\api\"
Push-Location $ApiDirectory

Get-ChildItem $ApiDirectory -Recurse -Filter *.csproj | 
Foreach-Object {
  buildthem $_.FullName
}

Write-Host "Emptying QueueConsumer publish directory" -ForegroundColor Blue
Remove-item -Force Navex.Insights.QueueConsumer\publish\*.*

Write-Host "Publishing Navex.Insights.QueueConsumer.csproj" -foregroundcolor Blue
dotnet publish 'C:\code\insights\api\Navex.Insights.QueueConsumer\Navex.Insights.QueueConsumer.csproj' -c Release -r win10-x64 -o 'C:\code\insights\api\Navex.Insights.QueueConsumer\publish'

Write-Host "Publishing Navex.Insights.API.csproj" -foregroundcolor Blue
dotnet publish 'C:\code\insights\api\Navex.Insights.API\Navex.Insights.API.csproj' --no-build -o 'C:\code\insights\API\publish'

Write-Host "restarting QueueConsumer" -foregroundcolor blue
C:\code\insights\api\Navex.Insights.QueueConsumer\publish\Navex.Insights.QueueConsumer.exe start
iisreset /start

Pop-Location
