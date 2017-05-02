class packstack::prereqs ()
{
    # We don't have openstack-selinux package for Fedora
    if $::operatingsystem != 'Fedora' {
      package{ 'openstack-selinux':
        ensure => present,
      }
    }

    package { 'sos':
      ensure => present,
    }
    
# One auditd instance by kernel is allowed. Use host auditd for Docker.
    if $::virtual != 'lxc' {
     if $::virtual != 'docker' {
      package { 'audit': ensure => present, } ->
      service { 'auditd': ensure => running, enable => true, }
     }
    }
}
