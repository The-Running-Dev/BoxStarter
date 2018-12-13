$arguments = @{
    url        = 'https://download.ccleaner.com/ccsetup551.exe'
    checksum   = '57C00353B459D6C164E32B1DE48A7537DCA2788C8D3EDA29BA50734FFA800B07'
    silentArgs = '/S'
}

# This adds a registry keys which prevent Google Chrome from getting installed together with Piriform software products.
$regDirChrome = 'HKLM:\SOFTWARE\Google\No Chrome Offer Until'
$regDirToolbar = 'HKLM:\SOFTWARE\Google\No Toolbar Offer Until'

if (Get-ProcessorBits 64) {
    $regDirChrome = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
    $regDirToolbar = $regDirChrome -replace 'SOFTWARE', 'SOFTWARE\Wow6432Node'
}
& {
    New-Item $regDirChrome -ItemType directory -Force
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirChrome -PropertyType DWORD -Value 20991231 -Force
    New-Item $regDirToolbar -ItemType directory -Force
    New-ItemProperty -Name "Piriform Ltd" -Path $regDirToolbar -PropertyType DWORD -Value 20991231 -Force
} | Out-Null

Install-Package $arguments

# Remove the shortcut on the desktop
Get-ChildItem "$env:Public\Desktop" CCleaner* | Remove-Item
