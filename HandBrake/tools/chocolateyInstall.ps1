<#
$arguments          = @{
    file            = 'HandBrake-1.0.7-x86_64-Win_GUI.exe'
    url             = 'https://handbrake.fr/rotation.php?file=HandBrake-1.0.7-x86_64-Win_GUI.exe'
    checksum        = '3D63E96BA3E0E538D6D7FCE86070FA5621B2BCD89123D53D25BBE625B7E7C4BA'
    silentArgs      = '/S'
}

Install-CustomPackage $arguments
#>

$arguments          = @{
    packageName     = "$env:ChocolateyPackageName-CLI"
    softwareName    = "$env:ChocolateyPackageTitle-CLI"
    destination   = Join-Path $env:ProgramFiles 'HandBrake'
    file            = 'HandBrakeCLI-1.0.7-win-x86_64.zip'
    url             = 'https://handbrake.fr/rotation.php?file=HandBrakeCLI-1.0.7-win-x86_64.zip'
    checksum        = 'B00C00520705E05BFB42701B4121DE8E56C9C283AF2B30D42CE10B24823519E0'
}

Install-CustomPackage $arguments
