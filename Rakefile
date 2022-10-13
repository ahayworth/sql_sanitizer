# frozen_string_literal: true

require "rake/testtask"
require "rake/extensiontask"

task default: :test

Rake::ExtensionTask.new("sql_sanitizer") do |c|
  c.lib_dir = "lib/sql_sanitizer"
end

task :dev do
  ENV['RB_SYS_CARGO_PROFILE'] = 'dev'
end

task bench: [:dev, :compile] do
  ruby "benchmark.rb"
end

task bench_short: [:dev, :compile] do
  ruby "benchmark.rb --short"
end

Rake::TestTask.new do |t|
  t.deps << :dev << :compile
  t.test_files = FileList["test/sanitize_test.rb"]
end
