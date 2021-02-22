
STOP-SERVICE Navex.Insights.CaseTransformationService -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.CdsService -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.EtlConsumer -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.PlatformUserTransformationService -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.QueueConsumer -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.S3ReaderService -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.Scheduler -ErrorAction SilentlyContinue
STOP-SERVICE Navex.Insights.TransformationConsumer -ErrorAction SilentlyContinue

SET-SERVICE Navex.Insights.CaseTransformationService -StartupType Manual
SET-SERVICE Navex.Insights.CdsService -StartupType Manual
SET-SERVICE Navex.Insights.EtlConsumer -StartupType Manual
SET-SERVICE Navex.Insights.PlatformUserTransformationService -StartupType Manual
SET-SERVICE Navex.Insights.QueueConsumer -StartupType Manual
SET-SERVICE Navex.Insights.S3ReaderService -StartupType Manual
SET-SERVICE Navex.Insights.Scheduler -StartupType Manual
SET-SERVICE Navex.Insights.TransformationConsumer -StartupType Manual

# sc.exe delete Navex.Insights.CaseTransformationService
# sc.exe delete Navex.Insights.CdsService
# sc.exe delete Navex.Insights.EtlConsumer
# sc.exe delete Navex.Insights.PlatformUserTransformationService
# sc.exe delete Navex.Insights.QueueConsumer
# sc.exe delete Navex.Insights.S3ReaderService
# sc.exe delete Navex.Insights.Scheduler
# sc.exe delete Navex.Insights.TransformationConsumer

$ApiDirectory = "\code\insights\api\"
Push-Location $ApiDirectory
Remove-Item -r Navex.Insights.API\publish\
Remove-Item -r Navex.Insights.API.Core\publish\
Remove-Item -r Navex.Insights.API.Tests\publish\
Remove-Item -r Navex.Insights.API.Tests.Integration\publish\
Remove-Item -r Navex.Insights.BirstMigrations\publish\
Remove-Item -r Navex.Insights.CaseTransformationService\publish\
Remove-Item -r Navex.Insights.Cds.LoadTest\publish\
Remove-Item -r Navex.Insights.CdsService\publish\
Remove-Item -r Navex.Insights.EtlConsumer\publish\
Remove-Item -r Navex.Insights.Integration.Core\publish\
Remove-Item -r Navex.Insights.Integration.UI\publish\
Remove-Item -r Navex.Insights.PlatformUserTransformationService\publish\
Remove-Item -r Navex.Insights.QueueConsumer\publish\
Remove-Item -r Navex.Insights.S3ReaderService\publish\
Remove-Item -r Navex.Insights.Scheduler\publish\
Remove-Item -r Navex.Insights.TransformationConsumer\publish\

MkDir Navex.Insights.API\publish\
MkDir Navex.Insights.API.Core\publish\
MkDir Navex.Insights.API.Tests\publish\
MkDir Navex.Insights.API.Tests.Integration\publish\
MkDir Navex.Insights.BirstMigrations\publish\
MkDir Navex.Insights.CaseTransformationService\publish\
MkDir Navex.Insights.Cds.LoadTest\publish\
MkDir Navex.Insights.CdsService\publish\
MkDir Navex.Insights.EtlConsumer\publish\
MkDir Navex.Insights.Integration.Core\publish\
MkDir Navex.Insights.Integration.UI\publish\
MkDir Navex.Insights.PlatformUserTransformationService\publish\
MkDir Navex.Insights.QueueConsumer\publish\
MkDir Navex.Insights.S3ReaderService\publish\
MkDir Navex.Insights.Scheduler\publish\
MkDir Navex.Insights.TransformationConsumer\publish\

Pop-Location
