function Get-Executable {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $baseDir,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $regEx
    )

    $searchDir = Get-BaseDirectory $baseDir
    $files = Get-ChildItem -Path $searchDir -Recurse | Where-Object { $_.Name -match $regEx }

    Write-Message "Get-Executable: Found $($files.Count) file(s) matching $regEx in $baseDir"

    # Always use the first file found
    if ($files.Count -gt 0) {
        Write-Message "Get-Executable: Executable is '$($files[0].FullName)'"

        return $files[0].FullName
    }
    elseif (!$files) {
        return
    }
}