require "bundler/gem_tasks"
# require 'rake/testtask'

# Rake::TestTask.new do |t|
#   t.libs << 'spec/'
#   t.test_files = Rake::FileList['spec/**/*_spec.rb']
#   t.verbose = true
# end

mock = ENV["FOG_MOCK"] || "true"

begin
  require "rubocop/rake_task"
  RuboCop::RakeTask.new do |t|
    t.patterns = Dir["{lib,spec,tests}/**/*"]
  end
rescue StandardError
  puts "Rubocop not loaded"
end

task :test do
  sh("export FOG_MOCK=#{mock} && bundle exec shindont tests/ovirt")
end

task(:default => [:test])
