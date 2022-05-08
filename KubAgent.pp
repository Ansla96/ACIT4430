node 'default' {
  include 'docker'
  include 'apt'
  include 'stdlib'
  
  user { 'Kirk':
  ensure => present,
  home => '/home/Kirk',
  password => 'Kirk123',
  }
  
  user { 'Rich':
  ensure => present,
  home => '/home/Rich',
  password => 'Rich123',
  } 
}
