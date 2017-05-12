$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.15.3/OctopusTools.4.15.3.zip'
    checksum    = '9343FFF00335BD577EABFD6ACC0D3DE47C2A1A65F1E4C4E5103D8B0CFF3D55E7'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

$env:Path = "$($env:Path);$($argumnets.destination)"
