function Set-ChocolateyPackageOptions {
    param(
        [Parameter(Position = 0, Mandatory = $true)][hashtable] $options
    )

    $packageParameters = $env:chocolateyPackageParameters

    if ($packageParameters) {
        $parameters = ConvertFrom-StringData -StringData $env:chocolateyPackageParameters.Replace(" ", "`n")

        $parameters.GetEnumerator() | ForEach-Object {
            $options[($_.Key)] = ($_.Value)
        }
    }
}