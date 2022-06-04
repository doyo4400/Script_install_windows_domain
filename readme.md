# Pieces of scripts for : 

- initialize Windows (Set IP, DNS, Name, Domain)
- install active directory
- install dhcp
- install dns
- manage AD (create user, ou, group...)

# Infos :
Script was test on Win2019

# Bonus :
- remind best practice to create AD (AGDLP)

# Diag : 
- Create firewall rule for allow incoming ping 
- [ ] netsh advfirewall firewall add rule name="ICMP Allow incoming V4 echo request" protocol="icmpv4:8,any" dir=in action=allow
- Disable all firewall rules
- [ ] Set-NetFirewallProfile -Profile Domain,Public,Private -Enabled False
