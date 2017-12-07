[CmdletBinding(SupportsShouldProcess = $true)]
Param(
)

$chocolateyBaseUrl = 'http://bit.ly/2tJNjx6'
$applicationsConfigUrl = ''

# No $PSScriptRoot if the install is executed remotely
if (-not $PSScriptRoot) {
    $PSScriptRoot = $env:Temp
}

$pcName = (@{ $true = $env:pc; $false = $env:ComputerName }[$env:pc -ne $null]).ToLower()
$chocolateyBaseDir = Join-Path $PSScriptRoot 'Chocolatey-Base'
$chocolateyBaseFile = Join-Path $PSScriptRoot 'Chocolatey-Base.zip'
$applicationsConfig = Join-Path $PSScriptRoot 'applications.config'
$pcSpecificAppplicationsConfig = Join-Path $PSScriptRoot "applications.$pcName.config"
$packagesDir = Join-Path $PSScriptRoot 'Packages'

if (Test-Path $pcSpecificAppplicationsConfig) {
    $applicationsConfig = $pcSpecificAppplicationsConfig
}
elseif (-not (Test-Path $applicationsConfig)) {
    # If the applicaiton config does not exist locally
    Invoke-WebRequest -Uri $applicationsConfigUrl -OutFile $applicationsConfig
}

Write-Host "Creating Directory: $chocolateyBaseDir"
New-Item -ItemType Directory $chocolateyBaseDir -Force | Out-Null

if (-not (Test-Path $chocolateyBaseFile)) {
    Write-Host "Downloding Chocolatey-Base.zip to $chocolateyBaseFile"
    Invoke-WebRequest -Uri $chocolateyBaseUrl -OutFile $chocolateyBaseFile
}

Expand-Archive $chocolateyBaseFile $chocolateyBaseDir

Get-ChildItem $chocolateyBaseDir *.ps1 | ForEach-Object {
    Write-Host "Executing $($_.FullName)"
    & $_.FullName -Force
}

if (-not (choco list Chocolatey-Personal -r -lo)) {
    Write-Host "Installing Chocolatey-Personal from $chocolateyBaseDir"
    choco install Chocolatey-Personal -s $chocolateyBaseDir
}

Remove-Item $chocolateyBaseDir -Recurse -Force

# If the applications config exists
if (Test-Path $applicationsConfig) {
    $chocoArgs = @()

    if (Test-Path $packagesDir) {
        Write-Host "Installing from $packagesDir"
        $chocoArgs += ('-s', $packagesDir)
    }

    # For the list of packages,
    # install each package only if it's not already installed
    Get-Content $applicationsConfig | ForEach-Object {
        if (-not (choco list $_ -r -lo)) {
            choco install $_ @chocoArgs
        }
    }
}