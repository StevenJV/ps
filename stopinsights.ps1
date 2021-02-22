Write-Host "stopping Insights services" -foregroundcolor blue -BackgroundColor White
START-SERVICE navex.intake.processor
START-SERVICE navex.distribution.processor
START-SERVICE navex.insights.queueconsumer
START-SERVICE navex.insights.TransformationConsumer
START-SERVICE navex.insights.EtlConsumer
START-SERVICE navex.insights.scheduler
START-SERVICE navex.insights.CdsService
START-SERVICE Navex.insights.CaseTransformationService
START-SERVICE Navex.insights.PlatformUserTransformationService
Write-Host "stopping IIS" -foregroundcolor blue -BackgroundColor White
iisreset /stop
