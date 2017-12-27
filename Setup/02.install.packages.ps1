Param(
    [Parameter(Position = 0)][switch] $force
)

$pcName = (@{ $true = $env:pc; $false = $env:ComputerName }[$env:pc -ne $null]).ToLower()
$defaultConfig = Join-Path $PSScriptRoot "install.config"
$pcConfig = Join-Path $PSScriptRoot "install.$pcName.config"

function Install-PackagesFromFile {
    param (
        [string] $configFile
    )

    if (Test-Path $configFile) {
        $chocoArgs = @()
        $chocoArgs += ('-s', $PSScriptRoot)
        $chocoArgs += ('-force')

        Get-Content $configFile | ForEach-Object {
            choco upgrade $_ @chocoArgs
        }
    }
}

# Always install thie common packages from the default config
Install-PackagesFromFile $defaultConfig

# Install any PC specific pages
Install-PackagesFromFile $pcConfig