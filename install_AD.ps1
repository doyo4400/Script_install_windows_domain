#variables
$domainname = "domain.local"
$domainNetBiosName = "name"
$networkid_for_dns = "192.168.0.0/24"
$children_domain_prefixe = "test"


#install AD DS role and managementTools for managing server (local)
Install-windowsfeature -name AD-Domain-Services -IncludeManagementTools

#create forest/domain
Install-ADDSForest -DomainName $domainname -DomainNetBiosName $domainNetBiosName

#add dns zone
Add-DnsServerPrimaryZone -NetworkID $networkid_for_dns -ReplicationScope "Domain"

#create children domain
Install-ADDSDomain -NewDomainName "$children_domain_prefixe" -ParentDomainName "$domainname" -domaintype childdomain -credential (Get-Credential)
