
#include fusioninventory

class fusioninventory::params {

  $pkgfusion          = 'fusioninventory-agent'
  $windowsmsi         = 'https://github.com/tabad/fusioninventory-agent-windows-installer/releases/download/2.3.18/fusioninventory-agent_windows-x86_2.3.18.exe'
  $crondest           = '/etc/cron.daily/fusioninventory'
  $server_url         = 'http://localhost/glpi/plugins/fusioninventory'
  $version            = 'latest'
  $service_ensure     = 'running'
  $service_enable     = true
  $cronscript_enable  = false
  $user               = undef
  $password           = undef
  $embedded_http      = true
  $no_ssl_check       = false
}
