require 'nanoc'
require 'nanoc/cli'

SITE_DIR = File.expand_path('_site_src')
CLEAN = %w[css images 2012]

task :clean do
  CLEAN.each { |fn| rm_rf fn }
end

desc 'compile the site with nanoc'
task :compile do
  Dir.chdir(SITE_DIR) { Nanoc::CLI.run %w[compile] }
end

desc 'view the site on local dev system'
task :view do
  Dir.chdir(SITE_DIR) { Nanoc::CLI.run %w[view] }
end


namespace :help do

  desc 'summarize task options'
  task :options do
    puts <<-EOT

The following environment variables modify the default behavior of
their command, e.g. `rake compile TCS_SITE_ROOT=/ruby`

`compile` options:

  TCS_SITE_ROOT  sets the created site's root dir [default: '/']
    EOT
  end

end
