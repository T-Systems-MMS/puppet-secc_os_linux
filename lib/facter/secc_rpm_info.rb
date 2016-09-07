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
  confine :kernel => 'Linux'
  if Facter.value(:osfamily) == 'RedHat' && Facter.value(:os)['release']['major'].to_i > 5
    package_grep = Facter::Util::Resolution.exec('rpm -qa --queryformat "%{NAME},%{VERSION}%{RELEASE};"')

    secc_rpm_info_hash = {}
    package_grep.split(";").each do |i|
      split_info = i.split(",")
      secc_rpm_info_hash[split_info[0]] = split_info[1]
    end

    chunk(:packageversion) do
      secc_rpm_info_hash
    end
  end
end