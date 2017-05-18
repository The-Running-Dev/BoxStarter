## Chocolatey Packages
  * Packages support custom installer location through a Chocolatey extension
    * The installer can embedded into the package
    * The installer can be in a local or network location (by setting )
    * The installer can be downloaded from the internet (like most packages on the Community feed)
    * The installer can be inside a zip file (local or downloaded from the internet)
    * The installer can be inside an ISO image
  * Most packages support automatic updates through the AU module, with the provided `update.ps1` script
  * AutoHotkey is used whenever full silent installation is not possible (Example ESET Nod32 Antivirus)

## Sample Install Script
  `
  # Execute https://raw.githubusercontent.com/The-Running-Dev/Chocolatey-BoxStarter/master/Install/install.sample.ps1
  iwr http://bit.ly/2pj2nQb -UseBasicParsing | iex
  `

## Packages
  * 7Zip
  * CCleaner
  * chocolatey
  * chocolatey-core.extension
  * Chocolatey-Dev.extension
  * Chocolatey-Package.extension
  * chocolatey.extension
  * ClipboardFusion
  * ConEmu
  * DisplayFusion
  * Docker
  * KB2919355
  * KB2919442
  * Driver-AsmediaUSB
  * Driver-INF
  * Driver-IntelBluetooth
  * Driver-IntelLan
  * Driver-IntelManagementEngine
  * Driver-IntelRapidStorage
  * Driver-IntelTurboBoostMax
  * Driver-IntelWirelessLan
  * Driver-RealtekHighDefinitionAudio
  * Dropbox
  * ESETNOD32Antivirus
  * Evernote
  * FLux
  * Git
  * GitExtensions
  * Google-Chrome
  * Google-Drive
  * HandBrake
  * HandBrake-CLI
  * iTunes
  * iTunesFusion
  * JetBrains-DataGrip
  * JetBrains-ReSharper-Platform
  * JetBrains-TeamCity
  * TeamCityAgent
  * JetBrains-WebStorm
  * JRE
  * K-LiteCodecPack
  * KDiff3
  * LastPass-Applications
  * Launchy
  * LogFusion
  * MetaX
  * Microsoft-BuildTools
  * Microsoft-DotNET3.5
  * Microsoft-DotNET4.5.2
  * Microsoft-DotNET4.6.2
  * Microsoft-DotNETCore-Runtime
  * Microsoft-DotNETCore-SDK
  * Microsoft-MSBuild
  * Microsoft-Office365Business
  * Microsoft-Office365Business-Embedded
  * Microsoft-PowerBI
  * Microsoft-SQLServer2014Developer
  * Microsoft-SQLServer2014Express
  * Microsoft-SQLServer2016Developer
  * Microsoft-SQLServer2016Express
  * Microsoft-SQLServerManagementStudio
  * Microsoft-VisualStudio2015Enterprise
  * Microsoft-VisualStudio2015Enterprise-Embedded
  * Microsoft-VisualStudioCode
  * Microsoft-WebPI
  * MySQL-Workbench
  * NodeJS
  * NTLite
  * NuGet-CommandLine
  * Octopus-Deploy
  * Octopus-Deploy-Tentacle
  * Octopus-Tools
  * Paint.NET
  * Powershell-Carbon
  * Powershell-CommunityExtensions
  * Powershell-Psake
  * ProGet
  * RazerSynapse
  * Recuva
  * Rufus
  * Slack
  * Spotify
  * TeamViewer
  * VisualCRedistributable2013
  * VisualCRedistributable2013x64
  * VisualCRedistributable2013x86
  * VisualCRedistributable2015
  * VisualCRedistributable2015x64
  * VisualCRedistributable2015x86
  * VMWare-PowerCLI
  * VMWare-RemoteConsole
  * VMWare-Workstation
  * VoiceBot
  * VPNAreaChameleon
  * Windows-IIS
  * Windows-IIS-ExternalCache
  * Windows-IIS-UrlRewrite
  * XYplorer


## Links
  * [Install BoxStarter](http://bit.ly/win10boxstarter)
  * [Install Chocolatey](http://bit.ly/win10boxstarter-choco)
  * [SQL Server Configuration](http://bit.ly/win10boxstarter-sqlserverconfig)
  * [Visual Studio AdminFile](http://bit.ly/win10boxstarter-vsadmin)
  * [Visual Studio BuildOnSave Add-In](http://bit.ly/win10boxstarert-vs-buildonsave)
  * [Visual Studio SaveAllTheTime Add-In](http://bit.ly/win10boxstarert-vs-saveallthetime)
  * [Visual Studio SpellChecker Add-In](http://bit.ly/win10boxstarter-vs-spellchecker)

## References
  * [Running Visual Studio Install from the Command Line](https://msdn.microsoft.com/en-us/library/mt720584.aspx)
  * [Visual Studio Package on Chocolatey](https://chocolatey.org/packages/VisualStudio2015Enterprise)

## Editor
https://jbt.github.io/markdown-editor
