$arguments      = @{
    file        = 'HandBrakeCLI-1.0.7-win-x86_64.zip'
    url         = 'https://handbrake.fr/rotation.php?file=HandBrakeCLI-1.0.7-win-x86_64.zip'
    checksum    = 'B00C00520705E05BFB42701B4121DE8E56C9C283AF2B30D42CE10B24823519E0'
    destination = Join-Path $env:ProgramFiles 'HandBrake'
}

Install-FromZip $arguments
