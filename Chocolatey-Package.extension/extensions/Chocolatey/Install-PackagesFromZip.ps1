function Install-PackagesFromZip {
    param(
       [parameter(Mandatory = $false)][ValidateNotNullOrEmpty()][string] $packagesZip = ''
    )

    # No file provided, find the Packages zip in the package directory
    if (![System.IO.File]::Exists($packagesZip)) {
        $packagesZip = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Include 'Packages.zip' | Select-Object -First 1 -ExpandProperty FullName)
    }

    # Still no file found, find the first zip in the package directory
    if (![System.IO.File]::Exists($packagesZip)) {
        $packagesZip = (Get-ChildItem -Path $env:ChocolateyPackageFolder `
            -Include *.zip | Select-Object -First 1 -ExpandProperty FullName)
    }

    Write-Message "Install-PackagesFromZip: From $packagesZip"

    $packagesDir = Join-Path $env:ChocolateyPackageFolder 'Packages'

    if (Test-Path $packagesDir) {
        Remove-Item $packagesDir -Recurse -Force -ErrorAction SilentlyContinue | Out-Null
    }
    New-Item -ItemType Directory $packagesDir | Out-Null

    Expand-Archive $packagesZip $packagesDir
    Write-Host ''

    Get-ChildItem $packagesDir *.nupkg | `
    ForEach-Object {
        $package = $_.Name -replace '(\.[0-9\.]+\.nupkg)', ''

        Write-Message "Installing $package"

        choco install $package -s $packagesDir
    }
}