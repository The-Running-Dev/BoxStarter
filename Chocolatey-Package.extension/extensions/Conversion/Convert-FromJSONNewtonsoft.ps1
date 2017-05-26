function ConvertFrom-JSONNewtonsoft {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $value
    )

    $obj = [Newtonsoft.Json.JsonConvert]::DeserializeObject($value, [Newtonsoft.Json.Linq.JObject])

    return convertFrom-JObject $obj
}