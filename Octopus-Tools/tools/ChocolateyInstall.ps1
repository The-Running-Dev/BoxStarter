$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.15.2/OctopusTools.4.15.2.zip'
    checksum    = '28EADC90962AF1BD4C091E1AFFA39DE8A4451234B7CD72B0D644E3EAEBC24BD1'
    destination = Join-Path $env:AppData 'Octopus'
}

Install-FromZip $arguments

$env:Path = "$($env:Path);$($argumnets.destination)"
