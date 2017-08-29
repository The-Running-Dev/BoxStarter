$arguments      = @{
    url         = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    checksum    = '218B169AF471C88C527F622B061F529080E19FA871FA93362D42FF7061FAA52F'
}

function Get-ChromeVersion() {
    $root   = 'HKLM:\SOFTWARE\Google\Update\Clients'
    $root64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'

    foreach ($r in $root,$root64) {
        $gcb = Get-ChildItem $r -ea 0 | ? { (gp $_.PSPath) -match 'Google Chrome binaries' }
        if ($gcb) { return $gcb.GetValue('pv') }
    }
}

if ($env:ChocolateyPackageVersion -eq (Get-ChromeVersion)) {
    Write-Host "Google Chrome $version is already installed."
    return
}

Install-Package $arguments
