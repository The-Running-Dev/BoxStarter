function Start-IISWebSite() {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name
    )

    if (Get-Item "IIS:\$name" -ErrorAction SilentlyContinue) {
        Write-Host "Starting web site '$name'..."
        Start-Website -Name $webSite
    }
}