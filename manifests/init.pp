#
# Configures fusioninventory-agent in host.
#

class fusioninventory (
  $pkgfusion          = $fusioninventory::params::pkgfusion,
  $server_url         = $fusioninventory::params::server_url,
  $windowsmsi         = $fusioninventory::params::windowsmsi,
  $crondest           = $fusioninventory::params::crondest,
  $version            = $fusioninventory::params::version,
  $service_ensure     = $fusioninventory::params::service_ensure,
  $service_enable     = $fusioninventory::params::service_enable,
  $cronscript_enable  = $fusioninventory::params::cronscript_enable,
  $user               = $fusioninventory::params::user,
  $password           = $fusioninventory::params::password,
  $embedded_http      = $fusioninventory::params::embedded_http,
  $no_ssl_check       = $fusioninventory::params::no_ssl_check
) inherits fusioninventory::params {
    include 'fusioninventory::install'

  if ($cronscript_enable == true){
    include   'fusioninventory::cronscript'
  }

  if ($service_enable == true){
    include   'fusioninventory::service'
  }

}
