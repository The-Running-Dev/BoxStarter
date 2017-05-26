$arguments      = @{
    url         = ''
    checksum    = ''
    silentArgs  = '/S'
}

Install-Package $arguments

$packageParameters = $env:chocolateyPackageParameters
$arguments = @{
    Port = 82
    Edition = 'LicenseKey'
    ConnectionString = 'Data Source=localhost; Initial Catalog=ProGet; Integrated Security=SSPI;'
}

If ($packageParameters) {
    $MATCH_PATTERN = "/([a-zA-Z]+):([`"'])?([a-zA-Z0-9- _]+)([`"'])?"
    $PARAMATER_NAME_INDEX = 1
    $VALUE_INDEX = 3

    if ($packageParameters -match $MATCH_PATTERN ) {
        $results = $packageParameters | Select-String $MATCH_PATTERN -AllMatches
        $results.matches | % {
            $arguments.Set_Item(
                $_.Groups[$PARAMATER_NAME_INDEX].Value.Trim(),
                $_.Groups[$VALUE_INDEX].Value.Trim())
        }
    }
}

$arguments.Keys | % {
    $silentArgs += ' "/' + $_ + ':' + $arguments[$_] + '"'
}
