$packageChecksum    = '5CA3400C444CF4B970833E0986656E907A318DBA4F85D37E70512D67B3087710'
$arguments          = @{
    url             = 'http://download.microsoft.com/download/F/4/2/F42AB12D-C935-4E65-9D98-4E56F9ACBC8E/wpilauncher.exe'
    checksum        = '5CA3400C444CF4B970833E0986656E907A318DBA4F85D37E70512D67B3087710'
    silentArgs      = ''
}

Install-Package $arguments

Stop-ProcessSafe WebPlatformInstaller
