$installer          = 'googlechromestandaloneenterprise64.msi'
$url                = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
$checksum           = 'F954E930F52FD93C9FBB68B7BA60153B2E31F1FFBC6188E12B47CEBE7E34B29A'

function Get-ChromeVersion() {
    $root   = 'HKLM:\SOFTWARE\Google\Update\Clients'
    $root64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'

    foreach ($r in $root,$root64) {
        $gcb = gci $r -ea 0 | ? { (gp $_.PSPath) -match 'Google Chrome binaries' }
        if ($gcb) { return $gcb.GetValue('pv') }
    }
}

if ($env:ChocolateyPackageVersion -eq (Get-ChromeVersion)) {
    Write-Host "Google Chrome $version is already installed."
    return
}

$arguments          = @{
    packageName     = $env:ChocolateyPackageName
    softwareName    = $evn:ChocolateyPackageTitle
    unzipLocation   = $env:ChocolateyPackageFolder
    file            = Join-Path $env:ChocolateyPackageFolder $installer
    url             = $url
    checksum        = $checksum
    fileType        = 'msi'
    checksumType    = 'sha256'
    silentArgs      = '/quiet'
    validExitCodes  = @(0, 1641, 3010)
}

Install-LocalOrRemote $arguments