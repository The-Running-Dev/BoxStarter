function Test-Url
{
    param(
        [Parameter(ValueFromPipeline = $true)] [string] $uri,
        [Parameter(ValueFromPipeline = $true)] [string] $expectedResponse
    )

    $expectedCode = 200;
    $timeoutSeconds = 60;

    Write-Host "Starting Verification Request for $uri"
    Write-Host "Expecting Response Code $expectedCode"
    Write-Host "Expecting Response: $expectedResponse"

    $timer = [System.Diagnostics.Stopwatch]::StartNew()
    $success = $false
    do
    {
        try
        {
            $response = Invoke-WebRequest -Uri $uri -Method Get -UseBasicParsing

            $code = $response.StatusCode
            $body = $response.Content;
            Write-Host "Recieved Response Code: $code"
            Write-Host "Recieved Response: $body"

            if($response.StatusCode -eq $expectedCode)
            {
                $success = $true
            }
            if ($success -and $ExpectedResponse)
            {
                $success = ($ExpectedResponse -eq $body)
            }
        }
        catch
        {
            # Anything other than a 200 will throw an exception so
            # we check the exception message which may contain the
            # actual status code to verify

            Write-Host "Request Failed."
            Write-Host $_.Exception

            if($_.Exception -like "*($expectedCode)*")
            {
                $success = $true
            }
        }

        if(!$success)
        {
            Write-Host "Trying Again in 5 Seconds..."
            Start-Sleep -s 5
        }
    }
    while(!$success -and $timer.Elapsed -le (New-TimeSpan -Seconds $timeoutSeconds))

    $timer.Stop()

    # Verify result
    if(!$success)
    {
        throw "Verification Failed - Giving Up."
    }

    Write-Host "Sucesss! Found Status Code $expectedCode"
}

Export-ModuleMember -Function *

function HyperV
{
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $enabled
    )

    if ($enabled -match 'on') {
        Enable-WindowsOptionalFeature -FeatureName 'Microsoft-Hyper-V-All' -Online
    }
    else {
        Disable-WindowsOptionalFeature -FeatureName 'Microsoft-Hyper-V-All' -Online
    }
}

function UnZip
{
    [Alias("uz")]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $file
    )

    if ([System.IO.Path]::IsPathRooted($file)) {
        $filePath = $file       
    }
    else {
        $filePath = Join-Path -Resolve . $file
    }

    $parentDirectory = Split-Path -Parent $filePath
    $destinationPath = Join-Path $parentDirectory ([System.IO.Path]::GetFileNameWithoutExtension($filePath))

    Get-ChocolateyUnzip -FileFullPath $filePath -Destination $destinationPath
}

function Stop-ProcessSafe
{
    param(
        [Parameter(Position = 0, Mandatory = $true)][string] $name
    )

    if (Get-Process -Name $name -ErrorAction SilentlyContinue) {
        Stop-Process -processname $name
    }
}

function Get-ProcessPath {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory = $true)] [string] $name
    )

    $path = ''
    $process = Get-Process -Name $name -ErrorAction SilentlyContinue

    if ($process) {
        $path = $process.Path
    }

    return $path
}