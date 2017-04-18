$arguments          = @{
    file            = 'OctopusTools.4.13.13.zip'
    $url            = 'https://download.octopusdeploy.com/octopus-tools/4.13.13/OctopusTools.4.13.13.zip'
    $checksum       = 'D513F879DC0D1AFF5ED2572FB5203FB85B2FBB1D454807B6FB8FBED30511C5D5'
}

Install-FromZip $arguments

$env:Path = "$($env:Path);$($env:ChocolateyPackageFolder)"
