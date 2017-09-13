$arguments          = @{
    url             = 'https://github.com/Maximus5/ConEmu/releases/download/v17.09.10/ConEmuSetup.170910.exe'
    checksum        = 'B72C7DA03F9DB0FFC5710E83F65BDDBEE5880641C17B0954B08D260AA69CC872'
    silentArgs      = "/p:x64 /quiet /norestart"
}

Install-Package $arguments
