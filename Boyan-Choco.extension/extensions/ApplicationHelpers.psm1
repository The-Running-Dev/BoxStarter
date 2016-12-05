function InstallNodeModule([string] $file, [string] $commandTemplate) {
    try {
        foreach ($line in Get-Content -Path $file | Where-Object {$_.trim() -notmatch '(^\s*$)|(^#)'})
        {
            $commmand = $commandTemplate.replace("##application##", $line)

            Write-Host "Installing: $commmand"

            & npm install -g $commmand
        }
    }
    catch {
         Write-Host "Failed: $($_.Exception.ToString())"
    }
}

function InstallNodeModule([string] $file)
{
    Write-Host "Installing Node Modules from $file"

    RunCommand $file "npm install ##token##"
}