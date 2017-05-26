$arguments = @{
    url        = 'https://download.microsoft.com/download/8/7/2/872BCECA-C849-4B40-8EBE-21D48CDF1456/ENU/x64/SharedManagementObjects.msi'
    checksum   = 'EA38D5231F6678089316D744EDC5B074AF735DDD933FD665CE961F602616640C'
}

Install-Package $arguments
