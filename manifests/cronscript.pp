
#include fusion inventory

class fusioninventory::cronscript inherits ::fusioninventory {
  $fusioninventory_server_url = $server_url
  file { $crondest:
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('fusioninventory/fusioninventory.erb'),
  }
}
