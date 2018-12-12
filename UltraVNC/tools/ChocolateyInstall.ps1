$arguments = @{
    url        = 'http://www.uvnc.eu/download/1223/UltraVNC_1_2_23_X64_Setup.exe'
    checksum   = 'C1E18360A1F0130F9A909169E3D7B0AC89E73FE328B3404C7109AA36982135DA'
    silentArgs = '/SP /VERYSILENT /NORESTART'
}

Install-Package $arguments
