require 'spec_helper_acceptance'

describe 'Class secc_os_linux' do
  context 'with default config' do

    let(:manifest) {
    <<-EOS
      class { 'secc_os_linux':
        ext_rootsh_enabled => false,
        ext_secure_mountpoint_tmp => false,
        ext_secure_mountpoint_var => false,
        ext_secure_mountpoint_var_tmp => false,
        ext_secure_mountpoint_home => false,
        ext_manage_passwords => false,
      }
    EOS
    }

    it 'should run without errors' do
      expect(apply_manifest(manifest, :catch_failures => true).exit_code).to eq(2)
    end

    it 'should re-run without changes' do
      expect(apply_manifest(manifest, :catch_changes => true).exit_code).to be_zero
    end

  # password policy and lockout
  # req. 27, 35, 37 / 3_37 Betriebssysteme
  # req. 40 / 3_21 Unix
  if os[:family] == 'redhat'
    if ( os[:release] >= '6' && os[:release] < '7.0' )
      describe file('/etc/pam.d/password-auth') do
        its(:content) { should_not match /^password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 type=$/ }
      end
      describe file('/etc/pam.d/system-auth') do
        its(:content) { should_not match /^password    requisite     pam_cracklib.so try_first_pass retry=3 minlen=10 dcredit=-1 ucredit=-1 lcredit=-1 ocredit=-1 type=$/ }
      end
    end
      describe file('/etc/pam.d/password-auth') do
        its(:content) { should_not match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
      end
      describe file('/etc/pam.d/password-auth-ac') do
        its(:content) { should_not match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
      end
      describe file('/etc/pam.d/system-auth') do
        its(:content) { should_not match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
      end
      describe file('/etc/pam.d/system-auth-ac') do
        its(:content) { should_not match /^password    requisite     pam_pwquality.so try_first_pass local_users_only retry=3 authtok_type=$/ }
      end
    end


  end
end
