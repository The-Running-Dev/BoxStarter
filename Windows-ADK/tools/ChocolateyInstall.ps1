$ChocoPackage = @{
    packageName = 'Windows Assessment and Deployment Kit'
    url = 'https://go.microsoft.com/fwlink/p/?linkid=859206'
    checksum = '13965AFA6E6889B5E93CF5222B0E0FEA'
    silentArgs = "/quiet /norestart /log $env:temp\win_adk.log /features +"
    fileType = 'exe'
    validExitCodes = @(0,3010)
}

Install-ChocolateyPackage @ChocoPackage
