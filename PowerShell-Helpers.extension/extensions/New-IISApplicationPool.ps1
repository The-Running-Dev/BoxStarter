function New-IISApplicationPool {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    if (-not (Get-Item "IIS:\AppPools\$name" -ErrorAction SilentlyContinue)) {
        Write-Host "Application pool '$name' does not exist...creating."
        New-Item "IIS:\AppPools\$name" -confirm:$false
    }
    else {
        Write-Host "Application pool '$name' already exists."
    }
}