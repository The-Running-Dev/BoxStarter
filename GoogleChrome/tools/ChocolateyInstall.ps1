$script = $MyInvocation.MyCommand.Definition
$os     = if ($IsSystem32Bit) { '' } else { '64' }

function Get-Chrome32bitInstalled {
    $registryPath = 'HKLM:\SOFTWARE\WOW6432Node\Google\Update\ClientState\'

    if (!(Test-Path $registryPath)) { return }

    gi $registryPath | % {
        if ((Get-ItemProperty $_.pspath).ap -eq '-multi-chrome') { return $true }
    }
}

function Get-ChromeVersion() {
    $root   = 'HKLM:\SOFTWARE\Google\Update\Clients'
    $root64 = 'HKLM:\SOFTWARE\Wow6432Node\Google\Update\Clients'

    foreach ($r in $root,$root64) {
        $gcb = gci $r -ea 0 | ? { (gp $_.PSPath) -match 'Google Chrome binaries' }
        if ($gcb) { return $gcb.GetValue('pv') }
    }
}

$version = $env:ChocolateyPackageVersion

if ($version -eq (Get-ChromeVersion)) {
    Write-Host "Google Chrome $version is already installed."
    return
}

$packageArgs      = @{
  packageName     = 'GoogleChrome'
  unzipLocation   = (Get-CurrentDirectory $script)
  fileType        = 'msi'
  file            = Join-Path (Get-ParentDirectory $script) "googlechromestandaloneenterprise${$os}.msi"
  url             = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise.msi'
  url64           = 'https://dl.google.com/tag/s/dl/chrome/install/googlechromestandaloneenterprise64.msi'
  softwareName    = 'GoogleChrome*'
  checksum        = 'f30e97b8bd48f9e0b9706f24461db6718a3b9bfc3ddb110cea5b952643c617c8'
  checksum64      = 'e87064ecdb9583b2ce3b61dad2248952d15ecb031ee5ab70587c29ed6baf8bd1'
  checksumType    = 'sha256'
  checksumType64  = 'sha256'
  silentArgs      = '/quiet'
  validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $packageArgs