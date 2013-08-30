require "bundler/gem_tasks"

require 'cucumber/rake/task'
Cucumber::Rake::Task.new(:features)

Cucumber::Rake::Task.new(:run_aruba_features, nil) do |t|
  t.cucumber_opts = "ARUBA_REPORT_DIR=doc --format progress"
end

task :check_for_pygments do
  unless system("pygmentize", [:err,:out]=>"/dev/null")
    raise "You're missing pygmentize, try:\n sudo easy_install Pygments"
  end
end

desc "Run Cucumber features generating Aruba Report using Pygments"
task :aruba_features => [:check_for_pygments, :run_aruba_features]

require 'rspec/core'
require 'rspec/core/rake_task'
RSpec::Core::RakeTask.new(:spec) do |spec|
  spec.pattern = FileList['spec/**/*_spec.rb']
end

task :default => [:spec, :features]
