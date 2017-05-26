function ConvertTo-Boolean {
    param (
        [parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][string] $value
    )

    if ('1,true,yes' -Match $value) {
        return $true
    }

    return $false
}