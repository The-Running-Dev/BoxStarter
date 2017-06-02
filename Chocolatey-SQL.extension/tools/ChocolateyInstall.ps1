$updatedOn = '2017.05.30 16:06:42'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All | Out-Null
