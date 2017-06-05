function Write-TeamCityMessage([string]$text, [string]$status = 'NORMAL', [string]$errorDetails) {
    $messageAttributes = @{ text = $text; status = $status }

    if ($errorDetails) {
        $messageAttributes.errorDetails = $errorDetails
    }

    Write-TeamCityServiceMessage 'message' $messageAttributes
}