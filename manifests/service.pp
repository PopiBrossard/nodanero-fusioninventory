
#include fusion inventory

class fusioninventory::service inherits ::fusioninventory {
    case $::osfamily {
      'Darwin': {
  file { '/opt/fusioninventory-agent/etc/agent.cfg':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('fusioninventory/agent.cfg.erb'),
    }
      }
      default:             {
  file { '/etc/fusioninventory/agent.cfg':
    ensure  => 'present',
    owner   => 'root',
    group   => 'root',
    mode    => '0755',
    content => template('fusioninventory/agent.cfg.erb'),
    notify  => Service[$pkgfusion],
    require => Package[$pkgfusion],
    }
  }
}

  case $::osfamily {
    'Debian': {
      augeas { 'fusion_default_daemon':
        changes => [
          'set /files/etc/default/fusioninventory-agent/MODE daemon'
        ],
        notify => Service[$pkgfusion],
      }
    }
  }

  service { $pkgfusion :
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => [ Package[$pkgfusion], File['/etc/fusioninventory/agent.cfg'] ],
  }
}
