function buildthem
{
    param
    (
        [parameter(Mandatory=$true)]
        [String] $path
    )
    process
    {
        #$msBuildExe = 'C:\Program Files (x86)\Microsoft Visual Studio\2017\Professional\MSBuild\15.0\Bin\msbuild.exe'
        $msBuildExe = MSBuild 
        
        Write-Host "Cleaning $($path)" -foregroundcolor Yellow
        & "$($msBuildExe)" "$($path)" /t:Clean /verbosity:quiet /property:Configuration=Release

        Write-Host "Building $($path)" -ForegroundColor Green
        & "$($msBuildExe)" "$($path)" /t:Build /verbosity:quiet /property:Configuration=Release
        
    }
}
. $PSScriptRoot\stopinsights.ps1

Write-Host "cleaning \logs\" -foregroundcolor blue -BackgroundColor White
remove-item c:\logs\*.* -force -exclude HostService-log*.txt


$ApiDirectory = "$PSScriptRoot\..\insights\api\"
Push-Location $ApiDirectory

Get-ChildItem $ApiDirectory -Recurse -Filter *.csproj | 
Foreach-Object {
  buildthem $_.FullName
}

Write-Host "Emptying QueueConsumer publish directory" -ForegroundColor Blue  -BackgroundColor White
Remove-item -Force Navex.Insights.QueueConsumer\publish\*.*

Write-Host "Publishing Navex.Insights.QueueConsumer.csproj" -foregroundcolor Blue -BackgroundColor White
dotnet publish 'C:\code\insights\api\Navex.Insights.QueueConsumer\Navex.Insights.QueueConsumer.csproj' -c Release -r win10-x64 -o 'C:\code\insights\api\Navex.Insights.QueueConsumer\publish'

Write-Host "Publishing Navex.Insights.API.csproj" -foregroundcolor Blue -BackgroundColor White
dotnet publish 'C:\code\insights\api\Navex.Insights.API\Navex.Insights.API.csproj' --no-build -o 'C:\code\insights\API\publish'


. $PSScriptRoot\startinsights.ps1

Pop-Location
