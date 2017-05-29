$packageChecksum    = '246245CD612AFE23F9B648E0CA6D277AEF80D92F587D32633FFAE83906FB66AF'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All | Out-Null
