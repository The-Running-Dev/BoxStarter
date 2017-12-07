function Expand-Zips {
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Leaf})][string] $configFile,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $baseDirectory
    )

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
                    packageName  = [System.IO.Path]::GetFileNameWithoutExtension($zipFile)
                    fileFullPath = $zipFile
                    destination  = $destinationPath
                }
                Get-ChocolateyUnzip @arguments
            }
        }
    }
    catch {
        Write-Host "Failed: $($_.Exception.Message)"
    }
}