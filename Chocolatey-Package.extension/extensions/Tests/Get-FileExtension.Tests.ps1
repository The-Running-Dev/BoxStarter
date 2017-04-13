<#
$env:moduleName = 'InstallHelpers.psm1'
$env:ModuleUnderTest = Join-Path (Split-Path -Parent $PSScriptRoot) $env:moduleName

Import-Module $env:ModuleUnderTest

Describe "Get-FileExtension" {
    InModuleScope InstallHelpers {
        Context "When a File is Passed In" {
            $file = 'C:\Some\Notepad.exe'
            $result = Get-FileExtension $file

            It "Should Return the File Extension" {
                $result | Should Be '.exe'
            }
        }
        Context "When a URL is Passed In" {
            $file = 'http://some.path/file.zip'
            $result = Get-FileExtension $file

            It "Should Return the File Extension" {
                $result | Should Be '.zip'
            }
        }
    }
}
#>