source 'https://artifacts.mms-at-work.de/artifactory/prj-devops-gem-all/'

## Fixed modules and special versions
## Upstream Beta
## NOTE: < 4.0.0. is true for 4.0.0.alpha1
gem 'net-ssh', '>= 3.2.1.beta1', '< 4.0.0.alpha1'

gem 'CFPropertyList', '2.2.8'

## This is local artifactory copy until released
## See https://github.com/voxpupuli/librarian-puppet/issues/37
gem 'librarian-puppet', '= 2.2.3b'

## Pinned Versions (to avoid json native compile)
## as 1.8.1 is part of ruby and does not need
## ruby devkit
gem 'json', '1.8.1'

gem 'test-kitchen', '1.15.0'           # Test Kitchen
gem 'kitchen-transport-rsync', '0.1.2' # for kitchen rsync
gem 'kitchen-puppet', '1.46.3'         # kitchen puppet driver
gem 'kitchen-vagrant', '1.0.0'        # kitchen vagrant driver
gem 'kitchen-ec2'
gem 'yamllint', '0.0.9'                # yaml lint task in Rakefile
gem 'rsync', '1.0.9'                   # for librarian-puppet rsync mode
gem 'rspec', '3.5.0'                   # rspec core, just update as installed by Rakefile
gem 'rake', '11.3.0'                   # for rake tasks, just update as installed by Rakefile
gem 'hiera-eyaml', '2.1.0'             # for eyaml commands
gem 'puppet-lint', '2.0.2'             # for puppet-lint calls
gem 'serverspec', '2.37.2'             # for 'rake spec' task
gem 'puppet', '>= 4.5.0'               # for librarian-puppet module installer (4.5 lightly tested with ruby 2.2)
