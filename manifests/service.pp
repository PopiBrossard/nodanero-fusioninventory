
#include fusion inventory

class fusioninventory::service inherits ::fusioninventory {
    case $::osfamily {
      'Darwin': {
  file { '/opt/fusioninventory-agent/etc/agent.cfg':
    ensure  => 'present',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0755',
    content => template('fusioninventory/agent.cfg.erb'),
    notify  => Service['org.fusioninventory.agent'],
    }
  file { '/opt/FusionInventory-Agent-2.4-1.pkg.tar.gz':
    ensure  => 'present',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0755',
    content => 'https://github.com/fusioninventory/fusioninventory-agent/releases/download/2.4/FusionInventory-Agent-2.4-1.pkg.tar.gz',
    notify  => Exec['fusioninventory-agent'],
    }
  exec { 'fusioninventory-agent':
    command => 'tar xfz /opt/FusionInventory-Agent-2.4-1.pkg.tar.gz && installer -pkg FusionInventory-Agent-2.4-1.pkg -target / -lang en',
    path    => '/usr/local/bin/:/usr/bin:/bin:/usr/local/sin/:/usr/sbin:/sbin',
    require => [ File['/opt/FusionInventory-Agent-2.4-1.pkg.tar.gz'] ],
    notify  => File['/opt/fusioninventory-agent/etc/agent.cfg'],
  }
  service { 'org.fusioninventory.agent':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => [ Exec['fusioninventory-agent'], File['/opt/fusioninventory-agent/etc/agent.cfg'] ],
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
  service { $pkgfusion :
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => [ Package[$pkgfusion], File['/etc/fusioninventory/agent.cfg'] ],
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
}
