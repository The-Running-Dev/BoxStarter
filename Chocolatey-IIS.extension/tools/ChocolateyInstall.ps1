$updatedOn = '2017.07.19 10:30:12'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All -NoRestart | Out-Null
