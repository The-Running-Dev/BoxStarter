$arguments      = @{
    url         = 'https://handbrake.fr/mirror/HandBrake-1.0.7-x86_64-Win_GUI.exe'
    checksum    = '3D63E96BA3E0E538D6D7FCE86070FA5621B2BCD89123D53D25BBE625B7E7C4BA'
    silentArgs  = '/S'
}

Install-Package $arguments

New-StartMenuShortcut (Join-Path $env:ProgramFiles 'HandBrake\HandBrake.exe')