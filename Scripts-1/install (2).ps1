[CmdletBinding(SupportsShouldProcess = $true)]
Param(
)

$pcName = (@{ $true = $env:pc; $false = $env:ComputerName }[$env:pc -ne $null]).ToLower()
$chocolateyBaseDir = Join-Path $PSScriptRoot 'Chocolatey-Base'
$chocolateyBaseFile = Join-Path $PSScriptRoot 'Chocolatey-Base.zip'
$packagesFile = Join-Path $PSScriptRoot "install.$pcName.config"
$packagesDir = Join-Path $PSScriptRoot 'Packages'

Write-Host "Creating Directory: $chocolateyBaseDir"
New-Item -ItemType Directory $chocolateyBaseDir -Force | Out-Null

if (-not (Test-Path $chocolateyBaseFile)) {
    Write-Host "Downloding Chocolatey-Base.zip to $chocolateyBaseFile"
    Invoke-WebRequest -Uri 'https://github.com/The-Running-Dev/BoxStarter-Scripts/blob/master/Chocolatey-Base/Chocolatey-Base.zip?raw=true' -OutFile $chocolateyBaseFile
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

if (Test-Path $packagesFile) {
    $chocoArgs = @()

    if (Test-Path $packagesDir) {
        Write-Host "Installing from $packagesDir"
        $chocoArgs += ('-s', $packagesDir)
    }

    # For the list of packages,
    # install each package only if it's not already installed
    Get-Content $packagesFile | ForEach-Object {
        if (-not (choco list $_ -r -lo)) {
            choco install $_ @chocoArgs
        }
    }
}