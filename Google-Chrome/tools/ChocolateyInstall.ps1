$arguments      = @{
    url         = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    checksum    = 'AD978D8F634DAEFBDC7DFE7FF71E13AF103A8F0F3E7CF7CA4DDABF19E683EB41'
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
