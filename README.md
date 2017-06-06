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
  * Apache-Httpd
  * BoxStarter
  * Boxstarter.Bootstrapper
  * Boxstarter.Chocolatey
  * BoxStarter.Common
  * Boxstarter.HyperV
  * BoxStarter.WinConfig
  * CCleaner
  * Chocolatey
  * Chocolatey-Core.extension
  * Chocolatey-Dev.extension
  * Chocolatey-IIS.extension
  * Chocolatey-Package.extension
  * Chocolatey-SQL.extension
  * Chocolatey.extension
  * ClipboardFusion
  * ConEmu
  * DatabaseDotNET
  * DisplayFusion
  * Docker
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
  * JetBrains-TeamCity-Agent
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
  * Microsoft-DotNET4.6.2-DevPack
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
  * Microsoft-SQLServer2016LocalDb
  * Microsoft-SQLServer2016SharedManagementObjects
  * Microsoft-SQLServerJDBCDriver
  * Microsoft-SQLServerManagementStudio
  * Microsoft-VisualCRedistributable2013
  * Microsoft-VisualCRedistributable2013x64
  * Microsoft-VisualCRedistributable2013x86
  * Microsoft-VisualCRedistributable2015
  * Microsoft-VisualCRedistributable2015x64
  * Microsoft-VisualCRedistributable2015x86
  * Microsoft-VisualStudio2015Enterprise
  * Microsoft-VisualStudio2015Enterprise-Embedded
  * Microsoft-VisualStudioCode
  * Microsoft-WebPI
  * MySQL-Workbench
  * NodeJS
  * NotepadPlusPlus
  * NTLite
  * NuGet-CommandLine
  * Octopus-Deploy
  * Octopus-Deploy-CommandLine
  * Octopus-Deploy-Tentacle
  * Packer
  * Paint.NET
  * PowerShell-Carbon
  * PowerShell-CommunityExtensions
  * PowerShell-PSake
  * ProGet
  * RazerSynapse
  * Recuva
  * RemoteDesktopManager
  * Rufus
  * Slack
  * Spotify
  * TeamViewer
  * uTorrent
  * VMWare-Converter
  * VMWare-PowerCLI
  * VMWare-RemoteConsole
  * VMWare-Workstation
  * VoiceBot
  * VPNAreaChameleon
  * WinDirStat
  * Windows-IIS
  * Windows-IIS-ExternalCache
  * Windows-IIS-UrlRewrite
  * WSUS-Offline-Update
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
