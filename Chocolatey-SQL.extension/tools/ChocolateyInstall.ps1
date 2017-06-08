$updatedOn = '2017.06.08 08:38:51'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All | Out-Null
