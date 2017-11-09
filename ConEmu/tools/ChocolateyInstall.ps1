$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.10.25/ConEmuSetup.171025.exe'
    checksum        = 'D34E6DBF626968D25760C0A84EC170740BCDE3415229BEBFB58715060EE489D1'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
