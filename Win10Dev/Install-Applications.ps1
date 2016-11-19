try {
	npm install -g angular-cli@latest

	if (Test-PendingReboot) { Invoke-Reboot }
}
catch {
	Write-ChocolateyFailure 'Installation Failed: ' $($_.Exception.ToString())
	throw
}

cinst VisualStudio2015Enterprise -y `
	-s "\\nas\Data\Applications\_Install\Programming\Chocolatey" `
	-packageParameters "--AdminFile http://bit.ly/win10boxstarter-vsadmin" `
	--installargs "/ProductKey YOURKEYHERE"

# ReSharper
cinst resharper-platform -y

Install-ChocolateyVsixPackage SpellChecker http://bit.ly/win10boxstarter-vs-spellchecker
Install-ChocolateyVsixPackage SaveAllTheTime http://bit.ly/win10boxstarert-vs-saveallthetime
Install-ChocolateyVsixPackage BuildOnSave https://bit.ly/win10boxstarert-vs-buildonsave

if (Test-PendingReboot) { Invoke-Reboot }