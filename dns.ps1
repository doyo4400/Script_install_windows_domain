#dns role install
Install-WindowsFeature -Name DNS -IncludeManagementTools



#add conditionnal dns forwarder
$zone_name = "contoso.com"
$ip_master_dns = "192.168.1.1"
Add-DnsServerConditionalForwarderZone -Name "$zone_name" -MasterServers $ip_master_dns -PassThru



# add dns forwarder unconditionnal
$ip_root_dns = "192.168.1.1"
Add-DnsServerForwarder -IPAddress $ip_root_dns -PassThru



#add primary DNS zone
$dnszonename = "contoso.com"
$zonefilename = "contoso.com.dns"
Add-DnsServerPrimaryZone -name $dnszonename -ZoneFile $zonefilename



#Add host record (A type)
$dnszonename = "contoso"
$hostname = "server"
$ipv4_addr = "192.168.1.1"
Add-DnsServerResourceRecordA -ZoneName $dnszonename -name $hostname -IPv4Address $ipv4_addr


#set dynamic update 
$dnszonename = "contoso.com"
$update_type = "NonsecureAndSecure" #choices: None / Secure / NonsecureAndSecure
Set-DnsServerPrimaryZone -Name $dnszonename -DynamicUpdate $update_type -PassThru



#allowed zone transfer for secondary server
$dnszonename = "contoso"
$ip_second_server = "192.168.1.1"
$security_tranfer = "TransferToSecureServers" # choices : NoTransfer / TransferAnyServer / TransferToZoneNameServer / TransferToSecureServers
Set-DnsServerPrimaryZone -name $dnszonename -secondaryservers $ip_second_server -securesecondaries $security_tranfer



#create dns secondary zone
$name_secondary_zone = "western.contoso.com"
$zonefile_name_secondary_zone = "western.contoso.com.dns"
$masterserver = "192.168.1.1"
Add-DnsServerSecondaryZone -Name $name_secondary_zone -ZoneFile $zonefile_name_secondary_zone -MasterServers $masterserver