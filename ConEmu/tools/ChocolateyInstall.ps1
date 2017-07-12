$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.07.09/ConEmuSetup.170709.exe'
    checksum        = '03ACDE03639075EB6ED1D98138B57BD940E1499FE351B4846F22D6A91F194421'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
