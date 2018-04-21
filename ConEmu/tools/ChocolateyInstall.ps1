$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v18.04.18/ConEmuSetup.180418.exe'
    checksum        = 'E8E71B095E9226958F43EC8E9C6414CEE5FE801A92944F98F7FD1F70F268062A'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
