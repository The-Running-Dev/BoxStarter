$env:installPackage = @{$true = 'BoxStarter-Personal'; $false = $env:installPackage}['' -Match $env:installPackage]
$env:log = "$env:UserProfile\Desktop\BoxStarter.log"

choco install LogFusion-Personal
& "${env:ProgramFiles(x86)}\LogFusion\LogFusion.exe" $env:log

choco install $env:installPackage -r --execution-timeout 14400 > $env:log