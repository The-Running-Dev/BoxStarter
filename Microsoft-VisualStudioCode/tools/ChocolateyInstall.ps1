$createDesktopIcon      = $false
$createQuickLaunchIcon  = $true
$addContextMenuFiles    = $true
$addContextMenuFolders  = $true
$addToPath              = $true

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

$arguments  = @{
    url         = 'https://az764295.vo.msecnd.net/stable/929bacba01ef658b873545e26034d1a8067445e9/VSCodeSetup-x64-1.18.1.exe'
    checksum    = '31EAAAC807C47784E2BCEAA2800FCE25FDA4BE4C78BFBC2315C6E474081FFE7D'
    silentArgs  = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
}

Install-Package $arguments
