Import-Module (Join-Path $(Split-Path -parent $MyInvocation.MyCommand.Definition) 'Helpers.psm1')

$packageName = 'ReSharper'
$executable = 'JetBrains.ReSharperUltimate.2016.2.2.exe'
$url = "https://download.jetbrains.com/resharper/$executable"
$checksum = 'eccad508fb83428f8c5a3a9a4fc9d930251f101f4929845fc4aea3ab004169dd';
$silentArgs = '/VsVersion=14.0;15.0 /SpecificProductNames=dotCover;dotMemory;dotPeek;dotTrace;ReSharperCpp;teamCityAddin;ReSharper /Silent=True'

Install $packageName $url $checksum $silentArgs