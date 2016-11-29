param(
    [string] $package
)

if ($package -eq '') {
    & .\build.ps1
    & .\push.ps1
}
else {
    & .\build.ps1 $package
    & .\push.ps1 $package
}