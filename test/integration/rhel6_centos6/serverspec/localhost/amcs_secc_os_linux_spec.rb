require 'spec_helper'

#print "os-array: "
#puts os

####
# disabled checks are only temp. disabled and have to be enabled to ensure compliance
####

# test if ipv6 is active, independent of kernel modules
# easier compared to iterate using the interface resource
	describe command('ip addr') do
		its(:stdout) { should_not match /inet6/ }
	end

	describe 'Linux kernel parameters' do
	# some OS do not display ipv6 parameters after disabling ipv6, negating checks
		context linux_kernel_parameter('net.ipv6.conf.all.forwarding') do 
			its(:value) { should_not eq 1 }
		end
		context linux_kernel_parameter('net.ipv6.conf.all.disable_ipv6') do 
			its(:value) { should_not eq 0 }
		end
		
		context linux_kernel_parameter('net.ipv4.ip_forward') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.rp_filter') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.conf.default.rp_filter') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.icmp_echo_ignore_broadcasts') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.icmp_ignore_bogus_error_responses') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.accept_source_route') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.default.accept_source_route') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.accept_redirects') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.default.accept_redirects') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.secure_redirects') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.default.secure_redirects') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.send_redirects') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.conf.default.send_redirects') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('net.ipv4.tcp_syncookies') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.icmp_ratelimit') do 
			its(:value) { should eq 100 }
		end
		context linux_kernel_parameter('net.ipv4.icmp_ratemask') do 
			its(:value) { should eq 88089 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.arp_ignore') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.conf.default.arp_ignore') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('net.ipv4.conf.all.arp_announce') do 
			its(:value) { should eq 2 }
		end
		context linux_kernel_parameter('net.ipv4.tcp_rfc1337') do 
			its(:value) { should eq 1 }
		end
		context linux_kernel_parameter('kernel.sysrq') do 
			its(:value) { should eq 0 }
		end
		context linux_kernel_parameter('fs.suid_dumpable') do 
			its(:value) { should eq 0 }
		end
		
		context linux_kernel_parameter('net.ipv4.conf.default.log_martians') do 
			its(:value) { should eq 1 }
		end
		
		context linux_kernel_parameter('net.ipv4.conf.all.log_martians') do 
			its(:value) { should eq 1 }
		end
		
		context linux_kernel_parameter('net.ipv4.tcp_timestamps') do 
			its(:value) { should eq 0 }
		end
		
		# kernel > 3.0 does not have this parameter
		context linux_kernel_parameter('kernel.exec-shield') do 
			its(:value) { should_not eq 0 }
		end
		context linux_kernel_parameter('kernel.randomize_va_space') do 
			its(:value) { should eq 2 }
		end
	end

# service status
	describe package('abrtd') do
		it { should_not be_installed }
	end
	describe package('autofs') do
		it { should_not be_installed }
	end
	describe package('avahi') do
		it { should_not be_installed }
	end
	describe package('avahi-daemon') do
		it { should_not be_installed }
	end
	describe package('cpuspeed') do
		it { should_not be_installed }
	end
	describe package('ftp') do
		it { should_not be_installed }
	end
	describe package('inetd') do
		it { should_not be_installed }
	end
	describe package('rlogin') do
		it { should_not be_installed }
	end
	describe package('rsh-server') do
		it { should_not be_installed }
	end
	describe package('telnet') do
		it { should_not be_installed }
	end
	describe package('telnet-server') do
		it { should_not be_installed }
	end
	describe package('tftp-server') do
		it { should_not be_installed }
	end
	describe package('ypserv') do
		it { should_not be_installed }
	end
	describe package('ypbind') do
		it { should_not be_installed }
	end
	describe package('xinetd') do
		it { should_not be_installed }
	end
	
#	if ( os[:family] == 'redhat' )
#		describe service('ntpd') do
#			it { should be_enabled }
#			it { should be_running }
#		end
#	end
#
#	if ( os[:family] == 'suse' )
#            describe service('ntpd') do
#				it { should be_running }
#            end
#		
#        if ( os[:release] == '11' )
#			describe service('ntp') do
#				it { should be_enabled }
#			end
#        end
#        
#        if ( os[:release] == '12' )
#			describe command('systemctl is-enabled ntpd') do
#				its(:stdout) { should match /^enabled$/ }
#			end
#        end      
#	end
	
	describe service('abrtd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('acpid') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('anacron') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('atd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('autofs') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('avahi-daemon') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('cups') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('dhcpd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('network-remotefs') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('haldaemon') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('lm_sensors') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('mdmonitor') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('named') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('netconsole') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('netfs') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('ntpdate') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('oddjobd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('portmap') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('qpidd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('quota_nld') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('rdisc') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('rhnsd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('rhsmcertd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('sendmail') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('smartd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('sysstat') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('telnet') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	describe service('vsftpd') do
		it { should_not be_enabled }
		it { should_not be_running }
	end
	
# profile setting for default umask
	describe file('/etc/profile') do
		its(:content) { should match /umask 027/ }
		its(:content) { should_not match /umask 022/ }
	end
	
# /etc/login.defs settings
	describe file('/etc/login.defs') do
		its(:content) { should match /^PASS_MIN_DAYS       0$/ }
	
		its(:content) { should match /^ENCRYPT_METHOD SHA512$/ }
		its(:content) { should_not match /ENCRYPT_METHOD MD5/ }
		its(:content) { should_not match /ENCRYPT_METHOD SHA256/ }
		its(:content) { should_not match /ENCRYPT_METHOD DES/ }
	
		its(:content) { should match /^UMASK 077$/ }
	end
	
# password policy and lockout
	if os[:family] == 'redhat'
		if ( os[:release] >= '6' && os[:release] < '7.0' ) 
			describe file('/etc/pam.d/password-auth') do
				its(:content) { should match /^password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 type=$/ }
			end
			describe file('/etc/pam.d/system-auth') do
				its(:content) { should match /^password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 type=$/ }
			end
		end
		if ( os[:release] >= '7' && os[:release] < '8.0' )
			describe file('/etc/security/pwquality.conf') do
				its(:content) { should match /^minlen = 10$/ }
				its(:content) { should match /^dcredit = -1$/ }			
				its(:content) { should match /^ucredit = -1$/ }			
				its(:content) { should match /^lcredit = -1$/ }		
				its(:content) { should match /^ocredit = -1$/ }				
			end
			describe file('/etc/pam.d/password-auth') do
				its(:content) { should match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
			end
			describe file('/etc/pam.d/password-auth-ac') do
				its(:content) { should match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
			end
			describe file('/etc/pam.d/system-auth') do
				its(:content) { should match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
			end
			describe file('/etc/pam.d/system-auth-ac') do
				its(:content) { should match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
			end
		end
	
	end
	if ( os[:family] == 'suse' )
		describe file('/etc/pam.d/common-password') do
			its(:content) { should match /^password requisite       pam_cracklib.so retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1$/ }
		end
	end
	
# umask setting
	describe command('umask') do
		its(:stdout) { should match /^0027$/ }
	end
	
# syslog settings 
	if (os[:family] == 'redhat')
		describe service('rsyslog') do
			it { should be_enabled }
			it { should be_running }
		end
		describe file('/etc/rsyslog.conf') do
			its(:content) { should match /^authpriv\.\*.* \/var\/log\/secure$/ }
		end
		describe file('/etc/rsyslog.d/secc-audit.conf') do
			its(:content) { should match /^local6\.\*.* \/var\/log\/bash_history$/ }
		end
	end
	
	if ( (os[:family] == 'suse') && (os[:release] == '12') )
		describe command('systemctl is-enabled rsyslog') do
			its(:stdout) { should match /^enabled$/ }
		end
		describe file('/etc/rsyslog.conf') do
			its(:content) { should match /^local6\.\*.* \/var\/log\/bash_history$/ }
			its(:content) { should match /^authpriv\.\*.* \/var\/log\/secure$/ }
		end
	end
	
	if ( (os[:family] == 'suse') && (os[:release] == '11') )
		describe service('syslog') do
			it { should be_enabled }
			it { should be_running }
		end
		describe file('/etc/syslog-ng/syslog-ng.conf') do
			its(:content) { should match /^destination authpriv { file\("\/var\/log\/secure"\); };$/ }
			its(:content) { should match /^log { source\(src\); filter\(f_authpriv\); destination\(authpriv\); };$/ }
			its(:content) { should match /^destination bashaudit { file\("\/var\/log\/bash_history"\); };$/ }
			its(:content) { should match /^log { source\(src\); filter\(f_bashaudit\); destination\(bashaudit\); };$/ }
		end
	end
	
# checking for users with empty password (2nd field in /etc/shadow shouldn't be empty, but special characters are okay; http://linux.die.net/man/5/shadow (encrypted passwords)
	describe command('awk -F":" \'($2 == "") {print $1}\' /etc/shadow') do
		its(:stdout) { should match /^$/ }
	end

# checking for modules
    if ( os[:release] >= '6' && os[:release] < '7.0' )
        describe command('modprobe --showconfig | grep blacklist') do
            its(:stdout) { should match /blacklist usb-storage/ }
            its(:stdout) { should match /blacklist firewire-core/ }
            its(:stdout) { should match /blacklist firewire-ohci/ }
        end
    end
    if ( os[:release] >= '7' && os[:release] < '8.0' )
        describe command('modprobe --showconfig | grep blacklist') do
            its(:stdout) { should match /blacklist usb_storage/ }
            its(:stdout) { should match /blacklist firewire_core/ }
            its(:stdout) { should match /blacklist firewire_ohci/ }
        end
    end
    
    describe command('modprobe usb-storage') do
        its(:exit_status) { should eq 1 }
    end
    
    describe command('modprobe firewire-core') do
        its(:exit_status) { should eq 1 }
    end

	describe file('/etc/modprobe.d/secc-blacklist.conf') do
		its(:content) { should match /^install cramfs        \/bin\/false$/ }
		its(:content) { should match /^install freevxfs      \/bin\/false$/ }
		its(:content) { should match /^install jffs2         \/bin\/false$/ }
		its(:content) { should match /^install hfs           \/bin\/false$/ }
		its(:content) { should match /^install hfsplus       \/bin\/false$/ }
		its(:content) { should match /^install squashfs      \/bin\/false$/ }
		its(:content) { should match /^install udf           \/bin\/false$/ }
	end

# checking for rootsh - redhat derivates only
	if (os[:family] == 'redhat')
#		describe command('w | awk -F\' \' \'{print $8}\'') do
#			its(:stdout) { should match /rootsh/ }
#			its(:stdout) { should_not match /\/bin\/bash/ }
#		end
	end
	
# mounts
  describe file('/tmp') do
    it { should be_mounted }
    it { should be_mounted.with( :options => { :nodev => true } ) }
    # noexec on /tmp prevents test-kitchen :/
    #it { should be_mounted.with( :options => { :noexec => true } ) }
    it { should be_mounted.with( :options => { :nosuid => true } ) }
  end 
  
  describe file('/var') do
    it { should be_mounted }
    it { should be_mounted.with( :options => { :nodev => true } ) }
    it { should be_mounted.with( :options => { :noexec => true } ) }
    it { should be_mounted.with( :options => { :nosuid => true } ) }
  end 
  
  describe file('/home') do
    it { should be_mounted }
    it { should be_mounted.with( :options => { :nodev => true } ) }
  end 

  describe command('mount | grep /var/tmp') do
    its(:stdout) { should match /\/var\/tmp/ }
  end