param([string] $name, [string] $forcedPackages, [string] $root = $PSScriptRoot)

$options = [ordered]@{
    Timeout = 100
    UpdateTimeout = 1200
    Threads = 10
    Push = $env:au_Push -eq 'false'
    PluginPath = ''
    PackagesDir = Join-Path -Resolve $PSScriptRoot '..\'
    PublishDir = Join-Path -Resolve $PSScriptRoot '..\..\..\BoxStarter'

    forcedPackages = $forcedPackages -split ' '
    BeforeEach = {
        param($packageName, $options)

        $p = $options.forcedPackages | Where-Object { $_ -match "^${packageName}(?:\:(.+))*$" }
        if (!$p) { return }

        $global:au_Force = $true
        $global:au_Version = ($p -split ':')[1]
    }
    AfterEach = {
        $packageDir = Join-Path $options.PackagesDir $Latest.PackageName
        $installerFile = Join-Path $packageDir ($Latest.FileName32 -replace '_x32', '')

        Get-ChildItem $packageDir *.nupkg | ForEach-Object { Move-Item $_.FullName $options.publishDir -Force }
        Get-ChildItem $packageDir *.ignore | Remove-Item
        #Remove-Item $installerFile
    }
}

if ($forcedPackages) { Write-Host "Forced Packages: $forcedPackages" }
$global:au_Root = $root
$global:info = UpdateAll -Name $name -Options $options