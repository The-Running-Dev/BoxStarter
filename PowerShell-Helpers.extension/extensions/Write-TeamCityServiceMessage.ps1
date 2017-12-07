function Write-TeamCityServiceMessage([string]$messageName, $messageAttributesHashOrSingleValue) {
    function escape([string]$value) {
        ([char[]] $value |
                %  { switch ($_) {
                    "|" { "||" }
                    "'" { "|'" }
                    "`n" { "|n" }
                    "`r" { "|r" }
                    "[" { "|[" }
                    "]" { "|]" }
                    ([char] 0x0085) { "|x" }
                    ([char] 0x2028) { "|l" }
                    ([char] 0x2029) { "|p" }
                    default { $_ }
                }
            } ) -join ''
    }

    if ($messageAttributesHashOrSingleValue -is [hashtable]) {
        $messageAttributesString = ($messageAttributesHashOrSingleValue.GetEnumerator() |
                %  { "{0}='{1}'" -f $_.Key, (escape $_.Value) }) -join ' '
        $messageAttributesString = " $messageAttributesString"
    }
    elseif ($messageAttributesHashOrSingleValue) {
        $messageAttributesString = (" '{0}'" -f (escape $messageAttributesHashOrSingleValue))
    }

    Write-Output "##teamcity[$messageName$messageAttributesString]"
}