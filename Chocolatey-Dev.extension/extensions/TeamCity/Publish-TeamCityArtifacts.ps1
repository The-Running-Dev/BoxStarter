function Publish-TeamCityArtifacts([string] $path) {
    Write-TeamCityServiceMessage 'publishArtifacts' $path
}