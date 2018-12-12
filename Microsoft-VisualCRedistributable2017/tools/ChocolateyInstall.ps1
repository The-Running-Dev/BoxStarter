$otherData = @{
    ThreePartVersion  = [version]'14.16.27012'
    FamilyRegistryKey = '14.0'
}

$force = $env:chocolateyPackageParameters -like '*Force*'

$runtimes = @{
    'x86' = @{
        RegistryPresent = $false
        RegistryVersion = $null
        DllVersion      = $null
        Arguments       = @{
            file       = 'Microsoft-VisualCRedistributable2017_x86.exe'
            url        = 'https://download.visualstudio.microsoft.com/download/pr/9fbed7c7-7012-4cc0-a0a3-a541f51981b5/e7eec15278b4473e26d7e32cef53a34c/vc_redist.x64.exe'
            checksum   = '7EADB463BDF3CD1DE633B0A292B485FCCA7647CA5F9145600F784C7DD5DDF115'
            silentArgs = '/Q /norestart'
        }
        Applicable      = $true
    }
    'x64' = @{
        RegistryPresent = $false
        RegistryVersion = $null
        DllVersion      = $null
        Arguments       = @{
            file       = 'Microsoft-VisualCRedistributable2017_x86.exe'
            url        = 'https://download.visualstudio.microsoft.com/download/pr/9fbed7c7-7012-4cc0-a0a3-a541f51981b5/e7eec15278b4473e26d7e32cef53a34c/vc_redist.x64.exe'
            checksum   = '7EADB463BDF3CD1DE633B0A292B485FCCA7647CA5F9145600F784C7DD5DDF115'
            silentArgs = '/Q /norestart'
        }
        Applicable      = (Get-ProcessorBits) -eq 64
    }
}

switch ([string](Get-ProcessorBits)) {
    '32' { $registryRoots = @{ x86 = 'HKLM:\SOFTWARE'; x64 = $null }
    }
    '64' { $registryRoots = @{ x86 = 'HKLM:\SOFTWARE\WOW6432Node'; x64 = 'HKLM:\SOFTWARE' }
    }
    default { throw "Unsupported Architecture: $_" }
}

foreach ($archAndRegRoot in $registryRoots.GetEnumerator()) {
    $arch = $archAndRegRoot.Key
    $regRoot = $archAndRegRoot.Value
    $regData = Get-ItemProperty -Path "$regRoot\Microsoft\DevDiv\vc\Servicing\$($otherData.FamilyRegistryKey)\RuntimeMinimum" -Name 'Version' -ErrorAction SilentlyContinue

    if ($regData -ne $null) {
        $versionString = $regData.Version

        try {
            $parsedVersion = [version]$versionString
            Write-Verbose "Version of installed runtime for architecture $arch in the registry: $versionString"

            # future-proofing in case Microsoft starts putting more than 3 parts here
            $normalizedVersion = [version]($parsedVersion.ToString(3))
            $runtimes[$arch].RegistryVersion = $normalizedVersion
        }
        catch {
        }
    }
}

$packageRuntimeVersion = $otherData.ThreePartVersion
foreach ($archAndRuntime in $runtimes.GetEnumerator()) {
    $arch = $archAndRuntime.Key
    $runtime = $archAndRuntime.Value

    $shouldInstall = $runtime.RegistryVersion -eq $null -or $runtime.RegistryVersion -lt $packageRuntimeVersion
    Write-Verbose "Runtime for $arch Applicable: $($runtime.Applicable); Version in Registry: [$($runtime.RegistryVersion)]; Should Install: $shouldInstall"

    if ($runtime.Applicable) {
        if (-not $shouldInstall) {
            if ($force) {
                Write-Warning "Forcing Installation for $arch Version $packageRuntimeVersion..."
            }
            else {
                if ($runtime.RegistryVersion -gt $packageRuntimeVersion) {
                    Write-Warning "Skipping Installation for $arch ...a Newer Version ($($runtime.RegistryVersion)) is Already Installed..."
                }

                continue
            }
        }

        Install-Package $runtime.arguments
    }
}
