Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.psm1')

$packageName = 'DataGrip'
$url = 'https://download.jetbrains.com/datagrip/datagrip-2016.2.6.exe'
$checksum = '7dcd1d9e70e6786aee40ffe3258fafb47d64d225249b973bb59565427459d826';

Install $packageName $url $checksum