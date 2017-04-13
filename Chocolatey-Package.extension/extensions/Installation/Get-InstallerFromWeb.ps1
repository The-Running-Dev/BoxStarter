function Get-InstallerFromWeb([Hashtable] $arguments) {
    if ($arguments['url']) {
		Write-Verbose "Get-InstallerFromWeb: Downloading from '$($arguments['url'])'"

        return Get-ChocolateyWebFile `
            -PackageName $arguments['packageName'] `
            -Url $arguments['url'] `
            -FileFullPath $arguments['file']
    }
}