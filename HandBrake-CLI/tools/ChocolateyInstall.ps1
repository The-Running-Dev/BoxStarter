$arguments      = @{
    url         = 'https://download2.handbrake.fr/1.1.2/HandBrakeCLI-1.1.2-win-x86_64.zip'
    checksum    = '8B275A6584A3A2D01244D4C372BF002ED6A9FC86189DBC18FF7A3204851C4FCD'
    destination = Join-Path $env:ProgramFiles 'HandBrake'
}

Install-FromZip $arguments
