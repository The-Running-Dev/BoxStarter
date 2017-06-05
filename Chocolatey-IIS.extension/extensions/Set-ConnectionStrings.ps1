function Set-ConnectionStrings {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $webConfig,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][PSCustomObject] $config
    )

    $xPath = "//ns:configuration/connectionStrings/add[@name=`"`$_`"]/@connectionString"
    $config | ForEach-Object { ($_ | Get-Member -MemberType *Property).Name } | Where-Object { $_ -match 'Connection' } | `
        ForEach-Object {
        $currentXPath = $ExecutionContext.InvokeCommand.ExpandString($xPath)
        Set-XmlValue $webConfig $currentXPath $config.$_
    }
}