$arguments      = @{
    url         = 'http://downloads.ntlite.com/files/NTLite_setup_x64.exe'
    checksum    = 'DB1F05CB2B09DCE64F5941DC44BF0BB8CCB954A6220B31CF17FC95AA0A76E957'
    silentArgs  = '/VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-'
}

Install-Package $arguments
