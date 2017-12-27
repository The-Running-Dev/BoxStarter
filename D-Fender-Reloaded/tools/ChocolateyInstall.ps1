$arguments      = @{
    url         = 'https://downloads.sourceforge.net/project/dfendreloaded/D-Fend%20Reloaded/D-Fend%20Reloaded%201.4.4/D-Fend-Reloaded-1.4.4-Setup.exe'
    checksum    = 'C3AB8B0EA57F0C7219FBD28793D08B7E436B00A47F11385349FD49DEF094666C'
    silentArgs  = '/S'
}

Install-Package $arguments
