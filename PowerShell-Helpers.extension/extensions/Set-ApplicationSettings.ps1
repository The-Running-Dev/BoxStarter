function Set-ApplicationSettings {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $webConfig,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][PSCustomObject] $config
    )

    Write-Host "Setting application setting in '$webConfig'"

    $config | `
        ForEach-Object {
            ($_ | Get-Member -MemberType *Property).Name
        } | `
        ForEach-Object {
        $currentXPath = $ExecutionContext.InvokeCommand.ExpandString("//ns:configuration/appSettings/add[@key=`"`$_`"]/@value")
        $value = $config.$_

        if ((Select-String "key=""$($_)""" -Path $webConfig) -and $value) {
            Write-Host "`t$($_): $value"
            Set-XmlValue $webConfig $currentXPath $value
        }
    }
}