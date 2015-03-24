name             'vps'
maintainer       'YOUR_COMPANY_NAME'
maintainer_email 'YOUR_EMAIL'
license          'All rights reserved'
description      'Installs/Configures vps'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '0.1.0'

depends "myusers"
depends "openssh"
depends "sysctl"
depends "csf"
depends "cms"
depends "zbackup"
depends "monit-ng"
depends "postfix"
depends "swap_tuning"
depends "hostnames"
depends "vesta"
