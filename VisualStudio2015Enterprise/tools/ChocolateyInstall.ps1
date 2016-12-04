$script                 = $MyInvocation.MyCommand.Definition
$packageName            = 'VisualStudio2015Enterprise'
$packageDir             = GetParentDirectory $script
$defaultConfiguration   = Join-Path (GetParentDirectory $script) 'Configuration.xml'

$packageParameters      = ParseParameters $env:chocolateyPackageParameters
$configuration          = GetConfigurationFile $packageParameters['Configuration'] $defaultConfiguration

echo "configuration: $configuration"

$packageArgs            = @{
    packageName         = $packageName
    unzipLocation       = (GetCurrentDirectory $script)
    fileType            = 'exe'
    url                 = 'https://download.microsoft.com/download/6/4/7/647EC5B1-68BE-445E-B137-916A0AE51304/vs_enterprise.exe'
    checksum            = '2848DDD11A5DB48F801A846A4C7162027CA2ADE2EF252143ABDE82AD9C9FDD97'
    checksumType        = 'sha256'
    softwareName        = 'VisualStudio2015Enterprise*'
    silentArgs          = "/Quiet /NoRestart /NoRefresh /Log $env:Temp\vs.log /AdminFile $configuration"
    validExitCodes      = @(
        0, # success
        3010, # success, restart required
        2147781575, # pending restart required
        2147205120  # pending restart required for setup update
    )
}

# If features were passed in through the command line
if ($packageParameters['Features']) {
    $features = $packageParameters.Split(',')
    [xml]$xml = Get-Content $configuration

    foreach ($feature in $features)
    {
        $node = $xml.DocumentElement.SelectableItemCustomizations.ChildNodes | ? {$_.Id -eq "$feature"}

        if ($node -ne $null)
        {
            $node.Selected = "yes"
        }
    }

    $xml.Save($configuration)
}

InstallFromLocalOrRemote $packageArgs