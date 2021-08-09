#Définition des variables
$IP_srv = "192.168.0.21"
$GW_srv = "192.168.0.254"
$Mask_srv = "24"
$IP_DNS = "192.168.0.1"
$Interface_eth_name = $get-interfacealias-name #or "Ethernet0"
$ntp_srv = "1.1.1.1"
$Nom_srv = "hostname"
$domain_name = "Domain NetBios Name"
$Admin_domain_name = "Administrateur"

#find name of ethernet interface
$get-interfacealias-name = (Get-NetIPInterface -AddressFamily IPv4 | Where InterfaceAlias -Like "Ethernet*").InterfaceIndex


#Change server IP :
New-NetIPAddress -IPAddress "$IP_srv" -PrefixLength "$Mask_srv" -InterfaceAlias "$Interface_eth_name" -DefaultGateway "$GW_srv"

#add dns
Set-DnsClientServerAddress -InterfaceAlias "$Interface_eth_name" -ServerAddresses "$IP_DNS"

#Define ntp server
w32tm /config /manualpeerlist:$ntp_srv /syncfromflags:manual

#Rename server :
Rename-Computer -NewName "$Nom_srv" -Force

#Restart for apply hostname
Restart-Computer

#add server to Active Directory domain
Add-Computer -DomainName "$domain_name" -DomainCredential $Admin_domain_name@$domain_name
