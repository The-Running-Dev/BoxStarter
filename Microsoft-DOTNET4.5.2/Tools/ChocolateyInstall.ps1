$arguments      = @{
    url         = 'http://download.microsoft.com/download/E/2/1/E21644B5-2DF2-47C2-91BD-63C560427900/NDP452-KB2901907-x86-x64-AllOS-ENU.exe'
    checksum    = '6C2C589132E830A185C5F40F82042BEE3022E721A216680BD9B3995BA86F3781'
    silentArgs  = "/Passive /NoRestart /Log $env:temp\net451.log"
}

if (-not (Test-Path "hklm:\SOFTWARE\Microsoft\.NETFramework\v4.0.30319\SKUs\.NETFramework,Version=v4.5.2")) {
    Install-Package $arguments
}
else {
    Write-Host "Microsoft .NET 4.5.2 Framework is already installed on your machine."
}
