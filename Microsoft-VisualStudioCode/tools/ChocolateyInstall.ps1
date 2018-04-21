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
    url         = 'https://az764295.vo.msecnd.net/stable/3aeede733d9a3098f7b4bdc1f66b63b0f48c1ef9/VSCodeSetup-x64-1.22.2.exe'
    checksum    = '8F10321BC920B9D593ED55BB3DDE0A325721169C4F8CF59258493681C22D1E83'
    silentArgs  = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
}

Install-Package $arguments
