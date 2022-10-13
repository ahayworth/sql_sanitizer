# frozen_string_literal: true

require "benchmark"
require_relative "./lib/sql_sanitizer"
require_relative "./test/queries"

puts "\n\n"

n = ARGV.include?("--short") ? 50_000 : 200_000

i = 0
QUERIES.each do |q, data|
  puts "-" * 100
  puts <<~EOF
    Benchmarking the following query:
      #{data[:unsanitized]}

  EOF

  Benchmark.bmbm do |x|
    x.report("#{q.to_s.sub(/test_/, '')} - obfuscate_sql (ruby)") do
      n.times { obfuscate_sql(data[:unsanitized]) }
    end

    x.report("#{q.to_s.sub(/test_/, '')} - sanitize_sql (rust)") do
      n.times { sanitize_sql(data[:unsanitized]) }
    end
  end

  puts "-" * 100
  puts

  i += 1
  break if ARGV.include?("--short") && i > 5
end
