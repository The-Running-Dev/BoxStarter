$script           = $MyInvocation.MyCommand.Definition
$arguments        = @{
  packageName     = 'iTunes'
  softwareName    = 'iTunes*'
  version         = '12.5.4'
  file            = Join-Path (Get-ParentDirectory $script) 'iTunes6464Setup.exe'
  fileType        = 'msi'
  destination     = (Get-CurrentDirectory $script)
  url             = 'https://secure-appldnld.apple.com/itunes12/031-86055-20161212-CC2643BA-BE1D-11E6-BD92-B2E982FDB0CC/iTunes6464Setup.exe'
  checksum        = '1875473F2DF42C5561CD3D5C12CF7150CB0C0BF7D4AFF5348C38FEE4484F216F'
  checksumType    = 'sha256'
  silentArgs      = '/qn /norestart'
  validExitCodes  = @(0, 3010, 1641)
}

# Check if the same version of iTunes is already installed
$app = Get-WmiObject -Class Win32_Product | Where-Object {$_.Name -match 'iTunes'}
if ($app -and ([version]$app.Version -ge [version]$arguments['version'])) {
  Write-Output $(
    'iTunes ' + $version + ' or higher is already installed. '
  )
}
else {
  $parameters = Get-Parameters $env:chocolateyPackageParameters
  $arguments['file'] = Get-Installer $arguments

  Get-ChocolateyUnzip @arguments

  $msiFilesList = (Get-ChildItem -Path $arguments['destination'] -Filter '*.msi' | Where-Object {
    $_.Name -notmatch 'AppleSoftwareUpdate*.msi'
  }).Name

  # Loop over each file and install it. iTunes requires all of them to be installed
  foreach ($msiFileName in $msiFilesList) {
    Install-ChocolateyInstallPackage `
      -packageName $msiFileName `
      -fileType $arguments['fileType'] `
      -silentArgs $arguments['silentArgs'] `
      -file (Join-Path $arguments['destination'] $msiFileName) `
      -validExitCodes $arguments['validExitCodes']
  }
}