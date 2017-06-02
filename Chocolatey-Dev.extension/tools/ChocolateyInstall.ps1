$updatedOn = '2017.06.01 13:24:25'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All | Out-Null
