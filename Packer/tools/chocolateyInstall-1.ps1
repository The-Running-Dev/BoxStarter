$url = 'https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_windows_386.zip'
$checksum = '445eae4ea9a1eaa42e62776c6917fd83c15f26df320afb77571e9c840152da3b'
$url64 = 'https://releases.hashicorp.com/packer/1.0.0/packer_1.0.0_windows_amd64.zip'
$checksum64 = '54b2c92548f0a4f434771703f083b6e0fbbf73a8bf81963fd43e429d2561a4e0'
$legacyLocation = "$env:SystemDrive\HashiCorp\packer"
$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\packer")) {
    if ([System.IO.Directory]::Exists("$env:ChocolateyInstall\lib\packer\tools")) {
        # clean old plugins and ignore files
        Write-Host "Removing old packer plugins"
        Remove-Item "$env:ChocolateyInstall\lib\packer\tools\packer-*.*"
    }
}
else {
    if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\packer")) {
        if ([System.IO.Directory]::Exists("$env:ALLUSERSPROFILE\chocolatey\lib\packer\tools")) {
            # clean old plugins and ignore files
            Write-Host "Removing old packer plugins"
            Remove-Item "$env:ALLUSERSPROFILE\chocolatey\lib\packer\tools" -Include "packer-*.*"
        }
    }
}

$unzipLocation = "$(Split-Path -parent $MyInvocation.MyCommand.Definition)"

Install-ChocolateyZipPackage "packer" "$url" "$unzipLocation" "$url64" `
    -checksum $checksum -checksumType $checksumType -checksum64 $checksum64 -checksumType64 $checksumType64

If (Test-Path $legacyLocation) {
    Write-Host "Removing old packer installation from $legacyLocation"
    Remove-Item $legacyLocation -Force -Recurse
}
