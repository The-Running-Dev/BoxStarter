[CmdletBinding(SupportsShouldProcess = $true)]
param(
)

$source = Join-Path $PSScriptRoot '..\..\BoxStarter' -Resolve
$destination = '\\nas\Applications\_BoxStarter'

Sync-Directory $source $destination