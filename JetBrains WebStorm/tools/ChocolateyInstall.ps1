Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.psm1')

$packageName = 'webStorm'
$url = 'https://download.jetbrains.com/webstorm/WebStorm-2016.3.1.exe'
$checksum = '87712823afbebe127471cb66674d22381be5e279470cb4c0b62d8b2638768c61';

Install $packageName $url $checksum