function Disable-WindowsFeatures
{
    param(
		[string] $file
	)

    Write-Message "Disabling Windows Features from $file"

    Invoke-Commands $file "choco uninstall ##token## -r -source WindowsFeatures -y"
}