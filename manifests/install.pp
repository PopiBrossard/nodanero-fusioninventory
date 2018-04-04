
#include fusioninventory

class fusioninventory::install inherits ::fusioninventory
{
    case $::osfamily {
#      'Darwin': {
#        package { $pkgfusion:
#        ensure          => installed,
#        source          => 'https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.3.21/FusionInventory-Agent-2.3.21-1.pkg.tar.gz',
#        install_options => ["-target /"],
#        }
#      }
      'Windows': {
        package { $pkgfusion:
        ensure          => installed,
        source          => 'https://github.com/tabad/fusioninventory-agent-windows-installer/releases/download/2.3.18/fusioninventory-agent_windows-x86_2.3.18.exe',
        install_options => ["/acceptlicense=yes /add-firewall-exception=yes \
        /execmode=service /installtasks=Full \
        /server=${server_url}"],
        }
      }
      'RedHat', 'CentOS':  {
        package {  $pkgfusion:
          ensure => $version,
        }
      }
      /^(Debian|Ubuntu)$/: {
        package {  $pkgfusion:
          ensure => $version,
        }
      }
      default:             { warning('This fusioninventory module does not yet work on your OS.') }
}

}
