[CmdletBinding(SupportsShouldProcess = $true)]
param(
)

function Invoke-ChocoSync {
    param(
        [Array] $packages,
        [string] $source
    )

    $textInfo = (Get-Culture).TextInfo
    $packagesDir = Join-Path $PSScriptRoot 'Packages'
    New-Item -ItemType Directory $packagesDir -Force | Out-Null
    Remove-Item $packagesDir\** -Recurse -Force

    choco source enable -n Chocolatey
    choco source enable -n Chocolatey.licensed

    $packages | ForEach-Object {
        $sourcePackage = choco list $_ -s $source -r -e
        if ($sourcePackage) {
            $sourcePackageVersion = [version]($sourcePackage -split '\|' | Select-Object -Last 1)
        }

        $publicFeedPackage = choco list $_ -s Chocolatey -r -e
        if ($publicFeedPackage) {
            $publicFeedPackageVersion = [version]($publicFeedPackage -split '\|' | Select-Object -Last 1)
        }

        if (-not $sourcePackage -or ($publicFeedPackageVersion -gt $sourcePackageVersion)) {
            if (-not (Get-ChildItem $packagesDir -Filter "$_.nuspec" -Recurse)) {
                if (-not $sourcePackage) {
                    Write-Host "You don't have $_, v$publicFeedPackageVersion is available, downloading..."
                }
                else {
                    Write-Host "You have $_ v$sourcePackageVersion, v$publicFeedPackageVersion is available, downloading..."
                }

                choco download $_ -outDir $packagesDir -s Chocolatey -r

                # Remove the downloaded package
                Get-ChildItem $packagesDir *.nupkg | Remove-Item -Force
            }
        }
    }

    Get-ChildItem (Join-Path $packagesDir 'download') *.nuspec -Recurse | ForEach-Object {
        $matchingPackage = $packages -match "^$($_.BaseName)$"
        if ($matchingPackage) {
            $packageName = $matchingPackage[0]
        }
        else {
            $packageName = $textInfo.ToTitleCase($_.BaseName)
        }

        # Set the ID in the nuspec file to fix the casing
        Set-XmlValue $_.FullName '//ns:id' $packageName

        # Rename chocolateyInstall to ChocolateyInstall to fix the casing
        Get-ChildItem $_.Directory 'ChocolateyInstall.ps1' | Move-Item -Destination (Join-Path $_.Directory 'ChocolateyInstall.ps1')

        # Rename the nuspec file to fix the casing
        Move-Item $_.FullName (Join-Path $_.Directory "$packageName.nuspec")

        # Copy the whole package to the root directory, can't move it at this point
        Copy-Item $_.Directory (Join-Path $packagesDir ($_.Directory.BaseName -replace $packageName, $packageName)) -Recurse
    }

    Get-ChildItem $packagesDir *.nuspec -Recurse | ForEach-Object {
        & choco pack $_.FullName -outDir $packagesDir
    }

    Get-ChildItem $packagesDir *.nupkg -Recurse | ForEach-Object { choco push $_.FullName -s $source -f }
    Get-ChildItem $packagesDir | Remove-Item -Recurse -Force

    choco source disable -n Chocolatey
    choco source disable -n Chocolatey.licensed
}

$sourceUrls = @(
    'http://nuget.gocontec.com/nuget/Contec/'
    'D:\Dropbox\BoxStarter'
)
$packages = @(
    'BoxStarter'
    'BoxStarter.BootStrapper'
    'BoxStarter.Chocolatey'
    'BoxStarter.Common'
    'BoxStarter.HyperV'
    'BoxStarter.WinConfig'
    'Chocolatey'
    'Chocolatey.extension'
    'Chocolatey-Core.extension'
    'Chocolatey-VisualStudio.extension'
    'Chocolatey-WindowsUpdate.extension'
)

$sourceUrls | ForEach-Object {
    Invoke-ChocoSync $packages $_
}