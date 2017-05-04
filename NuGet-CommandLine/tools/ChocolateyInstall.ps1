$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.14.1/OctopusTools.4.14.1.zip'
    checksum    = '172F316436C9C2EA920490C369FA2D02B410FCE99C7BC868E9B319017681007E'
}

Install-FromZip $arguments

$env:Path = "$($env:Path);$($env:ChocolateyPackageFolder)"
