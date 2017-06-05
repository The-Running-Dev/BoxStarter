$updatedOn = '2017.06.05 14:16:08'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All -NoRestart | Out-Null
