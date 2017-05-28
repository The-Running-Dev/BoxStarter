$packageChecksum    = 'ABD8EC579EA8C6A71C9877F954BFE23399A29FAFCD346AB20E6FC129B0C93293'

# This is needed so we can get the WebAdministration module
Enable-WindowsOptionalFeature -FeatureName IIS-WebServer -Online -All | Out-Null
