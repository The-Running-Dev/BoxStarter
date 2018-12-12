$arguments = @{
    url        = 'https://download.jetbrains.com/webstorm/WebStorm-2018.3.1.exe'
    checksum   = 'F5C00A6F1A73982D03BFFC88F31D4447F9F57E34BDA03904EAEB1C72E579857D'
    silentArgs = "/S /CONFIG=$env:ChocolateyPackageFolder\Silent.config"
}

$programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$installDir = "$programFiles\JetBrains\webstorm $env:ChocolateyPackageVersion"

$parameters = Get-Parameters

if ($parameters.InstallDir) {
    $installDir = $parameters.InstallDir
}

$arguments.silentArgs += " /D=`"$installDir`""

New-Item -ItemType Directory -Force -Path $installDir | Out-Null

Install-Package $arguments
