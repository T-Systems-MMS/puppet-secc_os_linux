### See http://jasonseifer.com/2010/04/06/rake-tutorial for help
### Configuration ###

# Detect Windows 
require 'rbconfig'
if RbConfig::CONFIG['host_os'] =~ /mswin|mingw|cygwin/ 
  is_windows=true
else
  is_windows=false
end

## Config 
devops_repos =  %w(localdev puppet-do)
optional_repos = [ 'jenkins' ]
devops_branch = ENV["branch"] ? ENV["branch"]: "development"

# Working directory 
workdir = File.dirname(__FILE__)
basedir = File.expand_path("../",workdir)

# Get the projectname from the folder name (PROJECT-localdev)
devops_project = File.basename(workdir).split("-")[0]

def find_repos(basedir,projectname,repos)
  # Determine installed / used repos 
  repos_found = []
  repos.each do |repocandidate|
    if Dir.exists?(File.expand_path("#{projectname}-#{repocandidate}/.git", basedir))
      repos_found << "#{projectname}-#{repocandidate}"
    end
  end
  repos_found
end

task :default => [ "prepare:all" ]

namespace :prepare do

  desc "Perform all documentation steps to prepare converge"
  task :all do
    puts "Preparing (on_windows=#{is_windows})"
    ## Configure credential Helper on Windows
    if is_windows 
        puts "\tConfiguring git credential.helper to 'wincred' (global and local) ..."
        sh "git config --global credential.helper 'wincred'"
        sh "git config credential.helper 'wincred'"
        ## remove all unwanted librarian-puppet versions
        puts "\tUninstalling librarian-puppet ..."
        sh "gem list librarian-puppet -i && gem uninstall -a -I -x librarian-puppet || exit 0"
    end
    ## Install bundler if not installed
    if !Gem::Specification::find_all_by_name('bundler').any?
        puts "\tInstalling bundler from https://artifacts.mms-at-work.de/artifactory/prj-devops-gem-all/ ..."
        sh "gem install bundler --clear-sources --source https://artifacts.mms-at-work.de/artifactory/prj-devops-gem-all/"
    end
    puts "\tInstalling all required gems ... (may take a while)"
    sh "bundle check || bundle install"
    puts "\tInstalling all required puppet modules ... (may take a while) "
    Rake::Task["librarian:install_modules"].invoke
  end
end

namespace :git do

  desc "Update and checkout local repositories #{devops_repos} from #{devops_branch}"
  task :pull do
    devops_repos = find_repos(basedir,devops_project, devops_repos + optional_repos)
    puts devops_repos
    puts "Updating all Repos (#{devops_repos})"
    devops_repos.each do |reponame|
      repodir = File.expand_path(reponame,basedir)
      puts "\tUpdating #{reponame} in #{repodir}"
      Dir.chdir(repodir)
      sh "git checkout #{devops_branch}"
      sh "git pull"
      Dir.chdir(workdir)
    end
  end
end

namespace :librarian do

  desc "Update dependencies from Puppetfile.tmpl"
  task :update_modules do
    packerdir = File.expand_path("#{devops_project}-localdev",basedir)
    puppetdir = File.expand_path("#{devops_project}-puppet-do",basedir)
    puppetfile = File.expand_path("Puppetfile",puppetdir)
    puppetfile_tmpl = File.expand_path("Puppetfile.tmpl",puppetdir)
    puts "\tCopying '#{puppetfile_tmpl}' to '#{puppetfile}'"
    cp(puppetfile_tmpl,puppetfile)
    Dir.chdir(packerdir)
    puts "\tUpdating Modules in #{packerdir}/modules"
    sh "librarian-puppet update --verbose"
    puts "\tGenerating #{puppetfile}"
    sh "ruby gen_puppetfile_from_puppetfile_dot_lock.rb > #{puppetfile}"
    Dir.chdir(workdir)
  end

  desc "Update dependencies on disk (no dependency resolutio)"
  task :install_modules do
    packerdir = File.expand_path("#{devops_project}-localdev",basedir)
    Dir.chdir(packerdir)
    puts "\tUpdating Modules in #{packerdir}/modules"
    sh "librarian-puppet install --verbose"
    Dir.chdir(workdir)
  end

end

