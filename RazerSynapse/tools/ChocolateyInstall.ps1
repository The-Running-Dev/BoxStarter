$arguments          = @{
    url             = 'http://dl.razerzone.com/drivers/Synapse2/win/Razer_Synapse_Framework_V2.20.17.413.exe'
    checksum        = 'F0874FBECA11FD7D908EA3C98EA02AF1A1599CF33C58D0F840777ED9EA75491D'
    silentArgs      = '/s'
}

Install-WithAutoHotKey $arguments
