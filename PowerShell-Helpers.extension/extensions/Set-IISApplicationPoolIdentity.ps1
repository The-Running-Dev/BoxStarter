function Set-IISApplicationPoolIdentity {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $name,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][string] $identityType
    )

    Write-Host "Setting the identity of applicataion pool '$name' to '$identityType'..."

    Set-ItemProperty "IIS:\AppPools\$name" -name processModel -value @{identitytype = "$identityType"}
}