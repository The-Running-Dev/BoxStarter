$arguments          = @{
    file            = 'rufus-2.14.exe'
    url             = 'http://rufus.akeo.ie/downloads/rufus-2.14.exe'
    checksum        = 'C1191E6690CBE5D872C3937A4BD352CBFA5178078D6F31C2BC2DCAB9A20F237C'
    silentArgs      = '/s'
}

Set-Content -Path ("$installer.gui") -Value $null

Install-CustomPackage $arguments
$url = 'http://rufus.akeo.ie/downloads/rufus-2.14.exe'
$checksum = 'C1191E6690CBE5D872C3937A4BD352CBFA5178078D6F31C2BC2DCAB9A20F237C'
$checksumType = 'sha256'
$toolsDir = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"
$installFile = Join-Path $toolsDir "rufus.exe"

  Get-ChocolateyWebFile -PackageName "$packageName" `
                        -FileFullPath "$installFile" `
                        -Url "$url" `
                        -Checksum "$checksum" `
                        -ChecksumType "$checksumType"
  Set-Content -Path ("$installFile.gui") -Value $null
