$arguments          = @{
    url             = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V2.20.17.302.exe'
    checksum        = 'AF4C3B0607AACEF6D4496F9B8E4F37F2A9D01C965435A708C5D8FAFF7BB26435'
    silentArgs      = '/s'
}

Install-WithAutoHotKey $arguments
