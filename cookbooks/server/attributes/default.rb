default.packages = %w(vim git at)

default.set_fqdn = 'server.fqdn'

# Don't create an ssh key for us
default.user.ssh_keygen = false

# default.openssh.server.permit_root_login = 'no'  
default.openssh.server.password_authentication = 'no'  
default.openssh.server.allow_groups = 'sudo'  
default.openssh.server.login_grace_time = '30'  
default.openssh.server.use_p_a_m = 'no'  
default.openssh.server.print_motd = 'no'  

# Recommended swappiness https://www.digitalocean.com/community/tutorials/how-to-configure-virtual-memory-swap-file-on-a-vps
default.sysctl.params.vm.swappiness = 30

# Recommended to remove 120 hung process alert https://www.digitalocean.com/community/tutorials/how-to-configure-virtual-memory-swap-file-on-a-vps
# Also http://lonesysadmin.net/2013/12/22/better-linux-disk-caching-performance-vm-dirty_ratio/
default.sysctl.params.vm.dirty_background_ratio = 5
default.sysctl.params.vm.dirty_ratio = 10

default.postfix.mail_type = "master"
default.postfix.main.inet_interfaces = "all"
default.postfix.aliases = { "root" => "alerts@sanchia.com.au" }
default.postfix.main.smtpd_use_tls = "no"
default.postfix.main.smtp_use_tls = "no"

