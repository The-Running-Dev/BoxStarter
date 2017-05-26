function Get-Parameters {
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, Mandatory, ValueFromPipeline)][ValidateNotNullOrEmpty()][string] $parameters = $env:ChocolateyPackageParameters
    )

    $arguments = @{}

    if ($parameters) {
        $match_pattern = "\/(?<option>([a-zA-Z0-9]+))(:|=|-)([`"'])?(?<value>([a-zA-Z0-9\-\s_\\:;\,\.\!\@\#\$\%\^\&\*\(\)_\+=]+))([`"'])?|\/(?<option>([a-zA-Z0-9]+))"

        if ($parameters -match $match_pattern) {
            $results = $parameters | Select-String $match_pattern -AllMatches

            $results.matches | ForEach-Object {
                $arguments.Add(
                    $_.Groups['option'].Value.Trim(),
                    $_.Groups['value'].Value.Trim())
            }
        }
        else {
            Throw "Package parameters were found but were invalid."
        }
    }

    return $arguments
}