$arguments      = @{
    url         = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    checksum    = 'B95DD22EA10627A36C8B84542ED57A88DD8AC452724EA9054343893524AED777'
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
