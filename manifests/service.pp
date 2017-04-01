
#include fusion inventory

class fusioninventory::service inherits ::fusioninventory {
  file { '/etc/fusioninventory/agent.cfg':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('fusioninventory/agent.cfg.erb'),
  }

  service { $::pkgfusion :
    ensure =>  $::service_ensure,
    enable =>  $::service_enable,
  }
}
