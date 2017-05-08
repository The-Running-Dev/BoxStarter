$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.15.1/OctopusTools.4.15.1.zip'
    checksum    = 'C49934BD25CD8F6F09095482A5BA14B561BF4F1B378848F303DEB857273A2B0B'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

$env:Path = "$($env:Path);$($argumnets.destination)"
