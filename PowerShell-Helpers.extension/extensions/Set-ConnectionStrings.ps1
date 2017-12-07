function Set-ConnectionStrings {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $webConfig,
        [Parameter(Position = 1, Mandatory, ValueFromPipelineByPropertyName)][ValidateNotNullOrEmpty()][PSCustomObject] $config
    )

    Write-Host "Setting connection strings in '$webConfig'"

    $config | `
        ForEach-Object {
        ($_ | Get-Member -MemberType *Property).Name
    } | `
        ForEach-Object {
        $currentXPath = $ExecutionContext.InvokeCommand.ExpandString("//ns:configuration/connectionStrings/add[@name=`"`$_`"]/@connectionString")
        $value = $config.$_

        if ((Select-String "name=""$($_)""" -Path $webConfig) -and $value) {
            Write-Host "`t$($_): $value"
            Set-XmlValue $webConfig $currentXPath $value
        }
    }
}