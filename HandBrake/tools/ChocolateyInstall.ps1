$arguments      = @{
    url         = 'https://download.handbrake.fr/releases/1.1.0/HandBrake-1.1.0-x86_64-Win_GUI.exe'
    checksum    = '9CF7C0813F91E16218EB770F834380CAD0D1641D93BA93926702562BD9D2EECE'
    silentArgs  = '/S'
}

Install-Package $arguments

New-StartMenuShortcut (Join-Path $env:ProgramFiles 'HandBrake\HandBrake.exe')
