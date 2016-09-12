######################################
### MANAGED BY PUPPET ['os_linux'] ###
### DON'T CHANGE THIS FILE HERE    ###
### DO IT ON THE PUPPET MASTER!    ###
######################################
# Fact: secc_kernel_info
#
# Purpose: Display the kernel version and the date of the last update.
#
# Resolution: Fact is useful for monitoring.
#
#
# Caveats:
#

require 'facter'
Facter.add(:secc_kernel_info, :type => :aggregate) do
    confine :kernel => 'Linux'
    if ( Facter.value(:osfamily) == 'RedHat' && Facter.value(:os)['release']['major'].to_i > 5 )
      kernel_grep = Facter::Core::Execution.exec('rpm -qa --last |egrep "kernel-[0-9]" | head -n1')
      version = Facter.value(:kernelrelease)

      if !kernel_grep.empty? or kernel_grep.match(/^[a-zA-Z0-9]+/)
          date_split = kernel_grep.split(" ")
          # 0 = RPM package (kernel-2.6.32-573.22.1.el6.x86_64)
          # 1..7 = install date (Fri 25 Mar 2016 03:01:55 AM CET)
          #
          parsed_date = DateTime.parse(date_split[2..7].join(" "))
          last_update_unixtime = parsed_date.strftime('%s')
          last_update = parsed_date.to_s
      else
          last_update = DateTime.new(1970).to_s
          last_update_unixtime = DateTime.new(1970).strftime('%s')
      end

      chunk(:version) do
        {"version" => version}
      end

      chunk(:last_update) do
        {"last_update" => last_update}
      end

      chunk(:last_update_unixtime) do
        {"last_update_unixtime" => last_update_unixtime}
      end
    end
end
