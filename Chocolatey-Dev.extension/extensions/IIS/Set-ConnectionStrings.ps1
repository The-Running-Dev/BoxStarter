function Set-ConnectionStrings {
    [CmdletBinding()]
    param(
        [Parameter(Position = 1, Mandatory = $true)][string] $webConfig,
        [Parameter(Position = 0, Mandatory = $true)][PSCustomObject] $config
    )

    $xPath = "//ns:configuration/connectionStrings/add[@name=`"`$_`"]/@connectionString"
    $config | ForEach-Object { ($_ | Get-Member -MemberType *Property).Name } | Where-Object { $_ -match 'Connection' } | `
        ForEach-Object {
        $currentXPath = $ExecutionContext.InvokeCommand.ExpandString($xPath)
        Set-XmlValue $webConfig $currentXPath $config[$_]
    }
}