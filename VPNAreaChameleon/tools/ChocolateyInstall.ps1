$packageChecksum    = 'A0BFDBED714DE82F9E1BA90CE28E6CEED3F110FB960056EB53316F02BDB1EE624A168662DD36CE7512FB7580F974945A507D811FF058191F6270B4476373C687E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855D3CA6FEC18AAF138A45B11C8069AAF1228EA7B50176937FF260793D2876DDF50'
$installScript      = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$arguments          = @{
    file            = 'VPNAreaChameleon.exe'
    url             = 'https://vpnarea.com/VPNAreaChameleon.exe'
    checksum        = '51B2904DA65ACD1FB57C9677CD09D26981C3C7326317FC1D631198E2ABC29AD6'
    silentArgs      = '/S'
}

# Launch the AutoHotkey script that will confirm the driver warning
Start-Process $installHelper

Install-Package $arguments

if (Get-Process -Name 'VPNManager' -ErrorAction SilentlyContinue) {
    Stop-Process -processname 'VPNManager'
}
