# See http://confluence.jetbrains.net/display/TCD5/FxCop_#FxCop_-UsingServiceMessages
function Import-TeamCityFxCopResult([string]$path) {
    Write-TeamCityServiceMessage 'importData' @{ type = 'FxCop'; path = $path }
}