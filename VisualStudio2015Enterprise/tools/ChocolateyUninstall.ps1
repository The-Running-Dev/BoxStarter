Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'VSModules.psm1')
 
Uninstall 'VisualStudio2015Enterprise' 'Microsoft Visual Studio Enterprise 2015' 'vs_enterprise.exe'

$installerType = 'exe'
$silentArgs = '/Uninstall /force /Passive /NoRestart'

$app = Get-WmiObject -Class Win32_Product | Where-Object { $_.Name -like "$applicationName*"} | Sort-Object { $_.Name } | Select-Object -First 1
if ($app -ne $null)
{
    $uninstaller = Get-Childitem "$env:ProgramData\Package Cache\" -Recurse -Filter $uninstallerName | ? { $_.VersionInfo.ProductVersion.StartsWith($app.Version)}

    if ($uninstaller -ne $null)
    {
        Uninstall-ChocolateyPackage $packageName $installerType $silentArgs $uninstaller.FullName
    }
}