$arguments = @{
    url      = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
    checksum = 'E080C523B419D0F706B3633FCBCE37ADA61F983BDEAB1084E3320C69BA2134A4'
}

function Get-ChromeVersion() {
    $root = 'HKLM:\SOFTWARE\Google\Update\Clients'
    $root64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'

    foreach ($r in $root, $root64) {
        $gcb = Get-ChildItem $r -ea 0 | ? { (gp $_.PSPath) -match 'Google Chrome binaries' }
        if ($gcb) { return $gcb.GetValue('pv') }
    }
}

if ($env:ChocolateyPackageVersion -eq (Get-ChromeVersion)) {
    Write-Host "Google Chrome $version is already installed."
    return
}

Install-Package $arguments

# Remove the shortcuts from the desktop
Get-ChildItem "$env:UserProfile\Desktop" "Google Chrome*" | Remove-Item -Force
Get-ChildItem "$env:Public\Desktop" "Google Chrome*" | Remove-Item -Force
