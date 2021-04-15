#variables
$name_extend = "name"
$1er_addr = "192.168.0.10"
$last_addr = "192.168.0.250"
$mask = "255.255.255.0"
$scope_ID = "192.168.0.0"
$router = "192.168.0.254"

#declare dns server doesn't work (escape caractere bug ?)
#change DNS at line 20 
#use this syntax : "1.1.1.1","1.1.1.2","1.1.1.3"


#Create extend :
Add-DhcpServerv4Scope -Name "$name_extend" -StartRange "$1er_addr" -EndRange "$last_addr" -SubnetMask "$mask" -State InActive

#Add option(s) for extend (gateway, expiration_bail):
Set-DhcpServerv4OptionValue -ScopeId "$scope_ID" -Router "$router"
Set-DhcpServerv4scope -ScopeId "$scope_ID" -LeaseDuration "8.00:00:00"
Set-DhcpServerv4OptionValue -ScopeId "$scope_ID" -OptionId 6 -Value "1.1.1.1","1.1.1.2","1.1.1.3"


#Active extend :
Set-DhcpServerv4Scope -ScopeId "$scope_ID" -Name "$name_extend" -State Active
