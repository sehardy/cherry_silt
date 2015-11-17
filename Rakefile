require 'bundler/gem_tasks'

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new do |t|
    t.formatters = ['progress']
    t.options = ['-D']
    t.patterns = %w(
      lib/**/*.rb
      spec/**/*.rb
      ./Rakefile
    )
  end

  task style: :rubocop
rescue LoadError
  puts 'Rubocop not available; disabling rubocop tasks'
end

require 'rspec/core/rake_task'

desc 'Run all specs'
RSpec::Core::RakeTask.new('spec')

desc 'Run unit specs'
RSpec::Core::RakeTask.new('spec:unit') do |t|
  t.pattern = 'spec/unit/*_spec.rb'
end

desc 'Run integration specs'
RSpec::Core::RakeTask.new('spec:integration') do |t|
  t.pattern = 'spec/integration/*_spec.rb'
end

begin
  require 'cucumber'
  require 'cucumber/rake/task'
  Cucumber::Rake::Task.new(:features)
rescue LoadError
  puts 'Cucumber/Aruba not available; disabling feature tasks'
  task :features
end

desc 'run all tests'
task default: [:rubocop, :spec, :features]
task test: :default
