$arguments      = @{
    url         = 'https://download.octopusdeploy.com/octopus/Octopus.3.16.2-x64.msi'
    checksum    = 'FB6E35BF77FC73523E933B401B2F9ED5FBEFB9BCD4FDE8ACEE7D54E361780379'
}

Install-Package $arguments
