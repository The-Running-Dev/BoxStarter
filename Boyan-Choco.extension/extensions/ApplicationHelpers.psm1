function InstallNodeModule([string] $file)
{
    Write-Host "Installing Node Modules from $file"

    RunCommand $file "npm install ##token##"
}