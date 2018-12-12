$arguments = @{
    url        = 'https://download.jetbrains.com/datagrip/datagrip-2018.3.exe'
    checksum   = 'E6BEB91AC0D5C71A68A6CE79C13784C9F1514816B98E313CF6A759A30D3BEF1D'
    silentArgs = "/S /CONFIG=$env:ChocolateyPackageFolder\Silent.config"
}

$programFiles = (${env:ProgramFiles(x86)}, ${env:ProgramFiles} -ne $null)[0]
$installDir = "$programFiles\JetBrains\DataGrip $env:ChocolateyPackageVersion"

$parameters = Get-Parameters

if ($parameters.InstallDir) {
    $installDir = $parameters.InstallDir
}

$arguments.silentArgs += " /D=`"$installDir`""

New-Item -ItemType Directory -Force -Path $installDir | Out-Null

Install-Package $arguments
