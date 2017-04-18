$packageChecksum    = '5CA3400C444CF4B970833E0986656E907A318DBA4F85D37E70512D67B3087710'
$arguments          = @{
    file            = 'wpilauncher.exe'
    url             = 'http://download.microsoft.com/download/F/4/2/F42AB12D-C935-4E65-9D98-4E56F9ACBC8E/wpilauncher.exe'
    checksum        = '5CA3400C444CF4B970833E0986656E907A318DBA4F85D37E70512D67B3087710'
}

Install-CustomPackage $arguments

Start-Sleep -s 5

if (Get-Process -Name WebPlatformInstaller) {
    Stop-Process -processname WebPlatformInstaller
}
