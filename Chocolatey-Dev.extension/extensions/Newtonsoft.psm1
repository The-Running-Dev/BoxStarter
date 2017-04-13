$newtonsoftJsonDll = Join-Path -resolve $PSScriptRoot 'Newtonsoft.Json.dll'

function ConvertFrom-JsonNewtonsoft
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [string] $string
    )

    $obj = [Newtonsoft.Json.JsonConvert]::DeserializeObject($string, [Newtonsoft.Json.Linq.JObject])

    return ConvertFrom-JObject $obj
}

function ConvertTo-JsonNewtonsoft
{
    param(
        [Parameter(Mandatory = $true, ValueFromPipeline = $true)] [object] $obj
    )

    if (!$asm) {
        $asm = [Reflection.Assembly]::LoadFile($newtonsoftJsonDll)
    }

    return [Newtonsoft.Json.JsonConvert]::SerializeObject($obj, [Newtonsoft.Json.Formatting]::Indented)
}

function ConvertFrom-JObject($obj) {
    if (!$asm) {
        $asm = [Reflection.Assembly]::LoadFile($newtonsoftJsonDll)
    }
    
    if ($obj -is [Newtonsoft.Json.Linq.JArray]) {
        $a = @()

        foreach($entry in $obj.GetEnumerator()) {
            $a += @(convertfrom-jobject $entry)
        }

        return $a
    }
    elseif ($obj -is [Newtonsoft.Json.Linq.JObject]) {
        $h = [ordered]@{}

        foreach($kvp in $obj.GetEnumerator()) {
            $val =  convertfrom-jobject $kvp.value

            if ($kvp.value -is [Newtonsoft.Json.Linq.JArray]) { $val = @($val) }
            $h += @{ "$($kvp.key)" = $val }
        }

        return $h
    }
    elseif ($obj -is [Newtonsoft.Json.Linq.JValue]) {
        return $obj.Value
    }
    else {
        return $obj
    }
}

Export-ModuleMember -Function *