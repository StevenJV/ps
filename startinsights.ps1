Write-Host "restarting Insights services" -foregroundcolor blue -BackgroundColor White
net start navex.intake.processor
net start navex.distribution.processor
net start navex.insights.scheduler
net start navex.insights.EtlConsumer
net start navex.insights.TransformationConsumer
net start navex.insights.queueconsumer
net start navex.insights.CdsService
net start Navex.Insights.CaseTransformationService
net start Navex.Insights.PlatformUserTransformationService
iisreset /start
# curl -X GET "https://api.dev.insights.local/public/v1/HealthCheck.Get" -H "accept: */*"
Invoke-RestMethod -Uri https://api.dev.insights.local/public/v1/HealthCheck.Get -Method Get