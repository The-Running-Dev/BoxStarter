function Set-TeamCityBlockOpened([string]$name, [string]$description) {
    $messageAttributes = @{ name = $name }

    if ($description) {
        $messageAttributes.description = $description
    }

    Write-TeamCityServiceMessage 'blockOpened' $messageAttributes
}