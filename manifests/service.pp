
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
#    notify  => Service['org.fusioninventory.agent'],
    }
  file { '/opt/FusionInventory-Agent.pkg.tar.gz':
    ensure  => 'present',
    owner   => 'root',
    group   => 'wheel',
    mode    => '0755',
    source => $macospkg,
    notify  => Exec['fusioninventory-agent.pkg'],
    }
  exec { 'fusioninventory-agent.pkg':
    creates => '/opt/fusioninventory-agent/',
    command => 'launchctl stop org.fusioninventory.agent; \
       tar xfz /opt/FusionInventory-Agent.pkg.tar.gz \
       && installer -pkg FusionInventory-Agent-2.5.2-1.pkg -target / -lang en \
       && mkdir /opt/fusioninventory-agent/ \
       && rm -rf FusionInventory-Agent-2.5.2-1.pkg; \
       launchctl start org.fusioninventory.agent',
    path    => '/usr/local/bin/:/usr/bin:/bin:/usr/local/sin/:/usr/sbin:/sbin',
    require => [ File['/opt/FusionInventory-Agent.pkg.tar.gz'] ],
    notify  => File['/opt/fusioninventory-agent/etc/agent.cfg'],
  }
  service { 'org.fusioninventory.agent':
    ensure  => $service_ensure,
    enable  => $service_enable,
    require => [ Exec['fusioninventory-agent.pkg'], File['/opt/fusioninventory-agent/etc/agent.cfg'] ],
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
