net stop navex.insights.queueconsumer
net stop navex.insights.TransformationConsumer
net stop navex.insights.EtlConsumer
# net stop navex.insights.scheduler
net stop navex.distribution.processor
net stop navex.intake.processor
iisreset /stop
remove-item c:\logs\*.* -force 
iisreset /start
net start navex.intake.processor
net start navex.distribution.processor
# net start navex.insights.scheduler
net start navex.insights.EtlConsumer
net start navex.insights.TransformationConsumer
net start navex.insights.queueconsumer
