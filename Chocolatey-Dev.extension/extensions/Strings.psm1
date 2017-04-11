function Get-String([string] $input, [string] $regEx) {
    return $($input -replace $regEx, '$1')
}

Export-ModuleMember -Function *