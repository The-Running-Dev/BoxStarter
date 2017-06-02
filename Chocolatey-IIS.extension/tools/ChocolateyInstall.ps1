$updatedOn = '2017.06.01 13:18:56'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All -NoRestart | Out-Null