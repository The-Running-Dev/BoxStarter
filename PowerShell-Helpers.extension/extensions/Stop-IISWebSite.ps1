function Stop-IISWebSite {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    if (Get-Item "IIS:\$name" -ErrorAction SilentlyContinue) {
        Write-Host "Stopping web site $name"
        Stop-Website -Name $name
    }
}