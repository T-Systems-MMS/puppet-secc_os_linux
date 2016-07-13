######################################
### MANAGED BY PUPPET ['os_linux'] ###
### DON'T CHANGE THIS FILE HERE    ###
### DO IT ON THE PUPPET MASTER!    ###
######################################
# Fact: secc_rpm_info
#
# Purpose: Display name and version of all installed packages.
#
#

require 'facter'
Facter.add(:secc_rpm_info, :type => :aggregate) do
  confine do
    if Facter.value(:osfamily) != 'windows' and ( Facter.value(:osfamily) == 'RedHat' && Facter.value(:os)['release']['major'].to_i > 5 )
      package_grep = Facter::Util::Resolution.exec('rpm -qa --queryformat "%{NAME},%{VERSION}%{RELEASE};"')
      arr_ws = package_grep.split(";")

      arr_wc = []
      (0...arr_ws.length).each do |i|
        arr_wc.push(arr_ws[i].split(","))
      end

      chunk(:packageversion) do
        secc_rpm_info_hash = {}
        arr_wc.each { |packageversion, version| secc_rpm_info_hash[packageversion] = version}
        secc_rpm_info_hash
      end
    end
  end
end
