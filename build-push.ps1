param(
    [string] $package,
    [string] $source = 'local',
    [string] $embed = ''
)

& .\build.ps1 $package $source $embed
& .\push.ps1 $package $source