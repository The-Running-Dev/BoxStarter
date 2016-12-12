function Get-CurrentDirectory([string] $scriptPath)
{
    return $(Split-Path -parent $scriptPath)
}

function Get-ParentDirectory([string] $scriptPath)
{
    return Join-Path -Resolve $(Split-Path -parent $scriptPath) ..
}

function Get-ProgramFilesDirectory()
{
    $programFiles = @{$true = "$env:programFiles (x86)"; $false = $env:programFiles}[64 -Match (get-processorBits)]

    return $programFiles
}

function Get-ConfigurationFile()
{
    param(
        [string] $configuration,
        [string] $defaultConfiguration
    )

    if ([System.IO.File]::Exists($configuration))
    {
        return $configuration
    }

    if (($configuration -as [System.URI]).AbsoluteURI -ne $null)
    {
        $localConfiguration = Join-Path $env:Temp (Split-Path -leaf $defaultConfiguration)

        if (Test-Path $localConfiguration)
        {
            Remove-Item $localConfiguration
        }

        Get-ChocolateyWebFile 'ConfigurationFile' $localConfiguration $configuration | Out-Null

        return $localConfiguration
    }

    return $defaultConfiguration
}

function Unzip()
{
    param(
        [string] $file,
        [string] $destination
    )

    try {
        Add-Type -AssemblyName System.IO.Compression.FileSystem
        [System.IO.Compression.ZipFile]::ExtractToDirectory($file, $destination)
    }
    catch {}
}

function UnzipSafe()
{
    param(
        [string]$file,
        [string] $destination
    )

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [System.IO.Compression.ZipFile]::OpenRead($file)

    foreach ($entry in $archive.Entries)
    {
        $entryTargetFilePath = [System.IO.Path]::Combine($destination, $entry.FullName)
        $entryDir = [System.IO.Path]::GetDirectoryName($entryTargetFilePath)

        # Ensure the directory of the archive entry exists
        if(!(Test-Path $entryDir)){
            New-Item -ItemType Directory -Path $entryDir | Out-Null
        }

        # If the entry is not a directory entry, then extract entry
        if(!$entryTargetFilePath.EndsWith("/")){
            try {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $entryTargetFilePath, $true);
            }
            catch {
                Write-Host $_.Exception.Message
            }
        }
    }
}

function UnzipFiles([string] $file, [string] $outputDir)
{
    $packagePath = Split-Path -parent $PSScriptRoot
    $filePath = Join-Path $packagePath $file

    try {
        foreach ($line in Get-Content -Path $filePath | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $settingsPath = Join-Path (Join-Path $packagePath $outputDir) $line.split('=')[0]
            $settingsDestinationPath = $line.split('=')[1]

            try {
                $settingsDestinationPath = Invoke-Expression $settingsDestinationPath
            }
            catch {}

            if ($settingsPath -ne $null -and (Test-Path $settingsPath)) {
                Write-Host "Unzipping $settingsPath to $($settingsDestinationPath)"

                Unzip $settingsPath $($settingsDestinationPath)
            }
        }
    }
    catch {
        Write-Host "Failed: $($_.Exception.Message)"
    }
}