function Unzip() {
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

function UnzipSafe() {
    param(
        [string]$file,
        [string]$destination
    )

    Add-Type -AssemblyName System.IO.Compression.FileSystem
    $archive = [System.IO.Compression.ZipFile]::OpenRead($file)

    foreach ($entry in $archive.Entries) {
        $entryTargetFilePath = [System.IO.Path]::Combine($destination, $entry.FullName)
        $entryDir = [System.IO.Path]::GetDirectoryName($entryTargetFilePath)

        # Ensure the directory of the archive entry exists
        if (!(Test-Path $entryDir)) {
            New-Item -ItemType Directory -Path $entryDir | Out-Null
        }

        # If the entry is not a directory entry, then extract entry
        if (!$entryTargetFilePath.EndsWith("/")) {
            try {
                [System.IO.Compression.ZipFileExtensions]::ExtractToFile($entry, $entryTargetFilePath, $true);
            }
            catch {
                Write-Host $_.Exception.Message
            }
        }
    }
}

function UnzipFiles([string] $configFile, [string] $baseDirectory) {
    try {
        foreach ($line in Get-Content -Path $configFile | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'}) {
            $zipFile = Join-Path $baseDirectory $line.split('=')[0]
            $destinationPath = $line.split('=')[1]

            try {
                $destinationPath = Invoke-Expression $destinationPath
            }
            catch {}

            if ($zipFile -ne $null -and (Test-Path $zipFile)) {
                Write-Host "Unzipping $zipFile to $($destinationPath)"

                $arguments = @{
                    packageName = [System.IO.Path]::GetFileNameWithoutExtension($zipFile)
                    fileFullPath = $zipFile
                    destination = $destinationPath
                }
                Get-ChocolateyUnzip @arguments
            }
        }
    }
    catch {
        Write-Host "Failed: $($_.Exception.Message)"
    }
}