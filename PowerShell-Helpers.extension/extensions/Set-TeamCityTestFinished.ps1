function Set-TeamCityTestFinished([string]$name, [int]$duration) {
    $messageAttributes = @{name = $name; duration = $duration}

    if ($duration -gt 0) {
        $messageAttributes.duration = $duration
    }

    Write-TeamCityServiceMessage 'testFinished' $messageAttributes
}