$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus-tools/4.13.14/OctopusTools.4.13.14.zip'
    checksum    = '9BA4D80ACA3E8EB815E299076B334C4B0470372460CA2A9DC14591C96F64AA6D'
}

Install-FromZip $arguments

$env:Path = "$($env:Path);$($env:ChocolateyPackageFolder)"
