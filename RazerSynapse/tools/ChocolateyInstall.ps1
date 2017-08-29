$arguments          = @{
    url             = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V2.21.00.712.exe'
    checksum        = '7EB2E80910E6AF84BFEC38E19781D5CA11577089ED28F85FBBB2554294A1FB2B'
    silentArgs      = '/s'
}

Install-WithAutoHotKey $arguments
