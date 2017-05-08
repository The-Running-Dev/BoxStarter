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
    url         = 'https://az764295.vo.msecnd.net/stable/f6868fce3eeb16663840eb82123369dec6077a9b/VSCodeSetup-1.12.1.exe'
    checksum    = '8357C5CC85BD7CF41392A64D0A1A10BFB7BC576E430F2D05DEDE455E879A12B6'
    silentArgs  = "/verysilent /suppressmsgboxes /mergetasks=$mergeTasks /log=""$env:temp\vscode.log"""
}

Install-Package $arguments
