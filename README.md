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
  * AirVideoServer
  * Apache-Httpd
  * Atom
  * BFGRepoCleaner.extension
  * Bonjour
  * CCleaner
  * ClipboardFusion
  * ConEmu
  * DatabaseDotNET
  * DatabaseMaster
  * DbMigration
  * D-Fender-Reloaded
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
  * Firefox
  * FLux
  * Git
  * GitExtensions
  * GitKraken
  * GitLFS
  * Google-Chrome
  * Google-Drive
  * HandBrake
  * HandBrake-CLI
  * Hashicorp-Packer
  * Hashicorp-Terraform
  * iTunes
  * iTunesFusion
  * jDownloader
  * JetBrains-DataGrip
  * JetBrains-Resharper-Platform
  * JetBrains-Rider
  * JetBrains-TeamCity
  * JetBrains-TeamCity-Agent
  * JetBrains-WebStorm
  * JRE
  * KDiff3
  * K-LiteCodecPack
  * LastPass-Applications
  * Launchy
  * LogFusion
  * MetaX
  * Microsoft-BuildTools
  * Microsoft-DotNET3.5
  * Microsoft-DOTNET4.5.2
  * Microsoft-DotNET4.6.2
  * Microsoft-DotNET4.6.2-DevPack
  * Microsoft-DotNETCore-Runtime
  * Microsoft-DotNETCore-SDK
  * Microsoft-MSBuildVSTargets
  * Microsoft-Office365Business
  * Microsoft-Office365Business-Embedded
  * Microsoft-PowerBI
  * Microsoft-SQLServer2016Developer
  * Microsoft-SQLServer2016Express
  * Microsoft-SQLServer2016LocalDb
  * Microsoft-SQLServer2016SharedManagementObjects
  * Microsoft-SQLServer2017Express
  * Microsoft-SQLServerJDBCDriver
  * Microsoft-SQLServerManagementStudio
  * Microsoft-VisualCRedistributable2013
  * Microsoft-VisualCRedistributable2015
  * Microsoft-VisualCRedistributable2017
  * Microsoft-VisualStudio2015Enterprise
  * Microsoft-VisualStudio2015Enterprise-Embedded
  * Microsoft-VisualStudioCode
  * Microsoft-WebPI
  * MySQL-Workbench
  * NodeJS
  * NordVPN
  * NotepadPlusPlus
  * NTLite
  * NuGet-CommandLine
  * OctopusDeploy
  * OctopusDeploy-CommandLine
  * OctopusDeploy-Tentacle
  * Paint.NET
  * Posh-GitHub
  * PowerShell
  * PowerShell-Carbon
  * PowerShell-CommunityExtensions
  * PowerShell-Helpers.extension
  * PowerShell-Pester
  * PowerShell-PoshGit
  * PowerShell-PSake
  * ProGet
  * RazerSynapse
  * Recuva
  * RemoteDesktopManager
  * Rufus
  * Skype
  * Slack
  * Spotify
  * Steam
  * TeamViewer
  * Tor-Browser
  * UltraVNC
  * uTorrent
  * VLC
  * VMWare-Converter
  * VMWare-PowerCLI
  * VMWare-RemoteConsole
  * VMWare-Workstation
  * VoiceBot
  * VPNAreaChameleon
  * WinDirStat
  * Windows-ADK
  * Windows-IIS
  * Windows-IIS-ExternalCache
  * Windows-IIS-UrlRewrite
  * WSUS-Offline-Update
  * XYPlorer
  * Zoom

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
