function ConvertFrom-JsonNewtonsoft
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [string] $string
    )

    if (!$global:asm) {
        $global:asm = [Reflection.Assembly]::LoadFile($global:newtonsoftJsonDll)
    }

    $obj = [Newtonsoft.Json.JsonConvert]::DeserializeObject($string, [Newtonsoft.Json.Linq.JObject])

    return convertFrom-JObject $obj
}