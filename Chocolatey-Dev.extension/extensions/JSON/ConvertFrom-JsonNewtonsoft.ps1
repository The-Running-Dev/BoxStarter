function ConvertFrom-JsonNewtonsoft {
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)][string] $string
    )

    $obj = [Newtonsoft.Json.JsonConvert]::DeserializeObject($string, [Newtonsoft.Json.Linq.JObject])

    return convertFrom-JObject $obj
}