function ConvertTo-Boolean {
    param (
        [parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $value
    )

    if ('1,true,yes' -Match $value) {
        return $true
    }

    return $false
}

Export-ModuleMember -Function *