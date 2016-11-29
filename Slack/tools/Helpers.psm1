# Parse input argument string into a hashtable
# Format: /param1=1234 /param2=1234
function ParseParameters ($s)
{
    $parameters = @{ }

    if (!$s)
    {
        return $parameters
    }

    $kvps = $s.Split(@(" "), [System.StringSplitOptions]::RemoveEmptyEntries)

    foreach ($kvp in $kvps)
    {
        $delimiterIndex = $kvp.IndexOf('=')
        if (($delimiterIndex -le 0) -or ($delimiterIndex -ge ($kvp.Length - 1))) { continue }

        $key = $kvp.Substring(1, $delimiterIndex - 1).Trim().ToLower()

        if ($key -eq '') { continue }

        $value = $kvp.Substring($delimiterIndex + 1).Trim()

        $parameters.Add($key, $value)
    }

    return $parameters
}

function Install {
param(
    [string] $packageName,
    [string] $url
)
    $installerType = 'exe'
    $validExitCodes = @(0)
    $silentArgs = "-s"

    $packageParameters = ParseParameters $env:chocolateyPackageParameters
    $settingsPath = $packageParameters['settingsPath']

    Install-ChocolateyPackage "$packageName" `
        "$installerType" `
        "$silentArgs" `
        "$url"
}

Export-ModuleMember *