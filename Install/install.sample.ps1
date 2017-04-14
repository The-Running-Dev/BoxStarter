Set-ExecutionPolicy Unrestricted

# Download and install Chocolatey
$chocoInstallScriptUrl = '/Install/install.choco.ps1'
$chocoInstallScript = Join-Path $env:Temp 'Install.Choco.ps1'
$downloader = New-Object System.Net.WebClient
$downloader.DownloadFile($chocoInstallScriptUrl, $chocoInstallScript)
& $chocoInstallScript

# Add the My-Get source that contains all the packages
choco source add -n='BoxStarter-MyGet' -s 'https://www.myget.org/F/win-boxstarter/api/v2' -priority=1
choco source add -n=Chocolatey -s "https://chocolatey.org/api/v2/" -priority=2

choco install ClipboardFusion
choco install ConEmu
choco install DisplayFusion
choco install DotNET
choco install DotNETCore Runtime
choco install DotNETCore SDK
choco install Drivers
choco install Dropbox
choco install ESETNOD32 Antivirus
choco install F.Lux
choco install Git
choco install GitExtensions
choco install Google Chrome
choco install Google Drive
choco install iTunes
choco install iTunesFusion
choco install JetBrains DataGrip
choco install JetBrains Resharper Platform
choco install JetBrains WebStorm
choco install JRE
choco install KDiff3
choco install K-LiteCodecPack
choco install LastPass for Applications
choco install Launchy
choco install LogFusion
choco install Microsoft MSBuild Targets
choco install Microsoft Office 365 Business
choco install Microsoft PowerBI
choco install Microsoft SQL Server 2014 Developer
choco install Microsoft SQL Server 2014 Express
choco install Microsoft SQL Server 2016 Developer
choco install Microsoft Visual Studio 2015 Enterprise
choco install Microsoft Visual Studio Code
choco install Microsoft WebPI
choco install MySQL Workbench
choco install NodeJS
choco install NTLite
choco install OctopusTools
choco install RazerSynapse
choco install Slack
choco install Spotify
choco install TeamCity (In Progress)
choco install TeamViewer
choco install Visual C Redistributable 2015
choco install Visual C Redistributable 2015 x64
choco install Visual C Redistributable 2015 x86
choco install VMWare Workstation
choco install VoiceBot
choco install VPNAreaChameleon
choco install Windows IIS
choco install Windows IIS ExternalCache module
choco install Windows IIS UrlRewrite module
choco install XYPlorer