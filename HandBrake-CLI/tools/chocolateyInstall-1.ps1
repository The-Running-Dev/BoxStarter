$arguments      = @{
    url         = 'https://download2.handbrake.fr/1.1.0/HandBrakeCLI-1.1.0-win-x86_64.zip'
    checksum    = '8A8B5370F4C0F397B5BC7FF626C29E68BCAF48993819044B2082F7C6632F74FF'
    destination = Join-Path $env:ProgramFiles 'HandBrake'
}

Install-FromZip $arguments
