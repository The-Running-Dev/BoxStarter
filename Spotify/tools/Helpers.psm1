function Install {
param(
    [string] $packageName,
    [string] $installer
)
    $installerType = 'exe'
    $validExitCodes = @(0)

    $installerPath = Join-Path $PSScriptRoot $installer

    Install-ChocolateyInstallPackage `
        -PackageName $packageName `
        -FileType $installerType `
        -File $installerPath `
        -ValidExitCodes $validExitCodes
}

function Unzip()
{
    param([string]$file, [string]$destination)

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}

Export-ModuleMember *