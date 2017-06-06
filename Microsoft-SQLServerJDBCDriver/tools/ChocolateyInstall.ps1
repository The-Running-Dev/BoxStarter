$target = Join-Path $env:ProgramFiles 'Microsoft JDBC DRIVER 6.0 for SQL Server'
$arguments = @{
    url        = 'https://download.microsoft.com/download/0/2/A/02AAE597-3865-456C-AE7F-613F99F850A8/enu/sqljdbc_6.0.8112.100_enu.exe'
    checksum = 'DF6921B801D3C5AEFD85B94F7A183CAF099E0B1867D2973CD8AF2856077AFA79'
    silentArgs = "'/auto `"$target`"'"
}

Install-Package $arguments
