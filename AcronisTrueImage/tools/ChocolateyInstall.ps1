$installer              = 'Acronis True Image 2017.exe'
$packageChecksum        = 'F03F3C83B1054FEE26241DF70DE6E45B60BF32002CA5BB04DA490CC52BB25680E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B855F7B9322A6D5634E4B4E35A66BBB064B069A7CE00C670F9575F926BEA36C6D218238DA0CB465BC85AFF0675665B1F7A8E0EE193B905318D5883DFCABE7C3305CB922D4448C6059FC619C9B9CD9CAAE293CF89AAFA12F52161A0183FBCA867D1F0E3B0C44298FC1C149AFBF4C8996FB92427AE41E4649B934CA495991B7852B85526C6BDC45968F7D2F20C8BE3AFFB01B8BA9426449B32FE5DE5E6B8ACAA7E2A75'
$installerScript        = Join-Path $env:ChocolateyPackageFolder 'Install.exe'
$defaultSettingsFile    = Join-Path $env:ChocolateyPackageFolder 'Settings.reg'
$parameters             = Get-Parameters $env:packageParameters
$parameters['file']     = Get-ConfigurationFile $parameters['file'] $defaultSettingsFile
$arguments              = @{
    packageName         = $env:ChocolateyPackageName
    softwareName        = $env:ChocolateyPackageTitle
    unzipLocation       = $env:ChocolateyPackageFolder
    file                = Join-Path $env:ChocolateyPackageFolder $installer
    fileType            = 'exe'
    validExitCodes      = @(0, 1641, 3010)
}

$installerPath = Get-Installer $arguments

Start-Process $installerPath

# Launch the AutoHotkey script that install the application
Start-Process $installerScript -Wait

Start-Sleep -s 5

Import-RegistryFile $parameters
