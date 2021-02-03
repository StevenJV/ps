Write-Host "stopping Insights services" -foregroundcolor blue -BackgroundColor White
#net stop navex.intake.processor
#net stop navex.distribution.processor
net stop navex.insights.queueconsumer
net stop navex.insights.TransformationConsumer
net stop navex.insights.EtlConsumer
net stop navex.insights.scheduler
net stop navex.insights.CdsService
net stop Navex.insights.CaseTransformationService
net stop Navex.insights.PlatformUserTransformationService
Write-Host "stopping IIS" -foregroundcolor blue -BackgroundColor White
iisreset /stop
