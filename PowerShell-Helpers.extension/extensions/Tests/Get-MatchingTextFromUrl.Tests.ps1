. (Join-Path $PSScriptRoot '..\Web\Get-MatchingTextFromUrl.ps1' -Resolve)

Describe "Get-MatchingTextFromUrl" {
    BeforeEach {
    }

    Context "When Match is Found" {
        Mock Invoke-WebRequest { return @{ Content = '<html> some html 1.0.1 more html</html>'} } -Verifiable

        $result = Get-MatchingTextFromUrl 'someUrl' '([0-9\.\-]+)'

        It "Should Return the Matching Text" {
            $result | Should Not BeNullOrEmpty
            $result | Should Be '1.0.1'
        }
    }
    Context "When RegEx Needs Multiple Matches" {
        Mock Invoke-WebRequest { return @{ Content = '<html> some html 1.0.1 2017 more html</html>'} } -Verifiable

        $result = Get-MatchingTextFromUrl 'someUrl' '([0-9\.\-]+).*(\d+)' '{0}.{1}' '$matches[1].$matches[2]'

        It "Should Return the Matching Text" {
            $result | Should Not BeNullOrEmpty
            $result | Should Be '1.0.1.2017'
        }
    }
}