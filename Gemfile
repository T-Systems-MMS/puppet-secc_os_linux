source 'https://rubygems.org'

group :acceptance do
  gem 'nokogiri', '~> 1.10.4'
  gem 'net-ssh'
  gem 'beaker-rspec'
  gem 'beaker', '~> 3.7'
  gem 'jruby-pageant'
  gem 'ffaker'
  gem 'highline'
  gem 'rake', '~> 10.1.0'
  if puppetversion = ENV['PUPPET_VERSION']
    gem 'puppet', puppetversion
  else
    gem 'puppet'
  end
  gem 'puppetlabs_spec_helper'
  gem 'puppet-lint', '1.1.0'
  gem 'puppet-syntax'
  # pin pry to avoid bug
  gem "pry", '< 0.13.0'
end
