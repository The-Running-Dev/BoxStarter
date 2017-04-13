function Import-RegistrySettings([string] $path)
{
    $files = Get-ChildItem -Path $path -Filter *.reg -Recurse

    foreach ($f in $files) {
        try {
            Write-Host "Importing: $($f.FullName)"
            & regedit /s $f.FullName
        }
        catch {
            Write-Host "Failed Importing: $f, Message: $($_.Exception.ToString())"
        }
    }
}