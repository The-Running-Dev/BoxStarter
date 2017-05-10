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

function Get-TeamCityService() {
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $serviceName
    )

    $service = Get-Service $serviceName -ErrorAction SilentlyContinue

    if ($service) {
        return $true
    }

    return $false
}

function Uninstall-Service {
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $serviceName
    )

    if (Get-TeamCityService $serviceName) {
        Stop-Service $service
    }

    if ($service) {
        & sc.exe delete $serviceName
    }
}
