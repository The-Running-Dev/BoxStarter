$ErrorActionPreference = 'Stop';

$createDesktopIcon = $false
$createQuickLaunchIcon = $true
$addContextMenuFiles = $true
$addContextMenuFolders = $true
$addToPath = $true

$parameters = Get-Parameters $env:chocolateyPackageParameters

if ($parameters.ContainsKey("nodesktopicon")) {
    $createDesktopIcon = $false
}

if ($parameters.ContainsKey("noquicklaunchicon")) {
    $createQuickLaunchIcon = $false
}

if ($parameters.ContainsKey("nocontextmenufiles")) {
    $addContextMenuFiles = $false
}

if ($parameters.ContainsKey("nocontextmenufolders")) {
    $addContextMenuFolders = $false
}

if ($parameters.ContainsKey("dontaddtopath")) {
    $addToPath = $false
}

$mergeTasks = "!runCode"

if ($createDesktopIcon) {
    $mergeTasks = $mergeTasks + ",desktopicon"
}

if ($createQuickLaunchIcon) {
    $mergeTasks = $mergeTasks + ",quicklaunchicon"
}

if ($addContextMenuFiles) {
    $mergeTasks = $mergeTasks + ",addcontextmenufiles"
}

if ($addContextMenuFolders) {
    $mergeTasks = $mergeTasks + ",addcontextmenufolders"
}

if ($addToPath) {
    $mergeTasks = $mergeTasks + ",addtopath"
}

$script           = $MyInvocation.MyCommand.Definition
$arguments          = @{
    packageName     = $packageName
    unzipLocation   = (Get-CurrentDirectory $script)
    fileType        = 'exe'
    file            = Join-Path (Get-ParentDirectory $script) 'VSCodeSetup-1.9.0.exe'
    url             = 'https://go.microsoft.com/fwlink/?LinkID=623230'
    softwareName    = 'VisualStudioCode*'
    checksum        = 'CC463AD26D0816A9422F254FF33FB0F394CEB2C16AC4A42B8E1DA0C62A99173B'
    checksumType    = 'sha256'
    silentArgs      = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
    validExitCodes  = @(0, 3010, 1641)
}

Install-LocalOrRemote $arguments