function convertFrom-JObject($obj) {
    if ($obj -is [Newtonsoft.Json.Linq.JArray]) {
        $a = @()

        foreach($entry in $obj.GetEnumerator()) {
            $a += @(convertFrom-JObject $entry)
        }

        return $a
    }
    elseif ($obj -is [Newtonsoft.Json.Linq.JObject]) {
        $h = [ordered]@{}

        foreach($kvp in $obj.GetEnumerator()) {
            $val =  ConvertFrom-JObject $kvp.value

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