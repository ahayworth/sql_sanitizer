# frozen_string_literal: true

require "minitest/autorun"
require_relative "../lib/sql_sanitizer"
require_relative "./queries"

class SanitizeTest < Minitest::Test
  QUERIES.each do |tc, data|
    define_method tc do
      assert_equal(data[:sanitized], sanitize_sql(data[:unsanitized]))
    end

    define_method "#{tc}_rust_ruby_equal" do
      rust = sanitize_sql(data[:unsanitized])
      ruby = obfuscate_sql(data[:unsanitized])
      assert_equal(rust, ruby)
    end

    define_method "#{tc}_ruby_sanitizes_sanely" do
      ruby = obfuscate_sql(data[:unsanitized])
      assert_equal(data[:sanitized], ruby)
    end
  end
end
