#variables :
$ldap_path_for_ou = "DC=domain,dc=local"
$OUname = "OU_name"

$AD_groupname = "name"
$ldap_path_for_group = "OU=users,DC=domain,dc=local"
$group_category = "Security" # choice : security, distribution
$group_scope = "Global" #choice : universal, global, domainlocal

$ad_username = "name"
$ldap_path_for_user = "OU=users,DC=domain,dc=local"


#create OU
New-ADOrganizationalUnit -Name "$OUname" -Path "$ldap_path_for_ou"

#create group
New-ADGroup $AD_groupname -Path $ldap_path_for_group -GroupCategory $group_category -GroupScope $group_scope 

#create user
New-ADUser -Name $ad_username -Path $ldap_path_for_user -AccountPassword(Read-Host -AsSecureString "InputPassword") -Enabled $true

#add user to group
Add-AdGroupMember -Identity $AD_groupname -Members $ad_username
