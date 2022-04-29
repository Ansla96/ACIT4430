$master = "PuppetSrv.openstacklocal"
$master_ip = "10.0.48.123"
$interval = "120"

host { 'PuppetSrv.openstacklocal' :
     name => $master,
     ensure => present,host_aliases => "PuppetSrv",
     ip => $master_ip
}
augeas { "puppet_default" :
       context => "/files/etc/default/puppet",  
       changes => ["set START yes"],  
       notify => Service['puppet'],
       }
augeas { "puppet.conf" :
       context => "/files/etc//puppetlabs/puppet/puppet.conf",
       changes => [
                   "set agent/server $master",
		   "set agent/runinterval $interval",
       ],  
       notify => Service['puppet'],
}
service { "puppet" :
       ensure => running,
       hasrestart => true,
       hasstatus => true,
       require => Augeas['puppet.conf','puppet_default'],
}
