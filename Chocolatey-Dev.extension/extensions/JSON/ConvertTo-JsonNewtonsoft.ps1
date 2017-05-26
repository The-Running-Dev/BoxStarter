function ConvertTo-JsonNewtonsoft {
    param(
        [Parameter(Position = 0, Mandatory = $true, ValueFromPipeline = $true)][object] $obj
    )

    return [Newtonsoft.Json.JsonConvert]::SerializeObject($obj, [Newtonsoft.Json.Formatting]::Indented)
}