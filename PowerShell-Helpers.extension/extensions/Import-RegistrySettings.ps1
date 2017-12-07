function Import-RegistrySettings {
    param (
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateScript( {Test-Path $_ -PathType Container})][string] $path
    )

    $files = Get-ChildItem -Path $path -Filter *.reg -Recurse

    foreach ($f in $files) {
        try {
            Write-Message "Importing: $($f.FullName)"
            & regedit /s $f.FullName
        }
        catch {
            Write-Message "Failed Importing: $f, Message: $($_.Exception.ToString())"
        }
    }
}