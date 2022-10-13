QUERIES = {
  test_select_where_single_quote: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` = 'secret' LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` = ? LIMIT 1;",
  },
  test_select_where_double_quote: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` = \"secret\" LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` = ? LIMIT 1;",
  },
  test_select_table_name_no_quotes: {
    unsanitized: "SELECT table.* FROM table WHERE id = 'secret' LIMIT 1;",
    sanitized:   "SELECT table.* FROM table WHERE id = ? LIMIT 1;",
  },
  test_select_where_numeric: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` = 1 LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` = ? LIMIT 1;",
  },
  test_select_where_numeric_negative: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` = -1 LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` = ? LIMIT 1;",
  },
  test_select_where_with_function: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `name` = UPPERCASE('lower') LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `name` = UPPERCASE(?) LIMIT 1;",
  },
  test_select_where_with_function_multiple_args: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `name` = COMMAND('table', 'lower') LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `name` = COMMAND(?, ?) LIMIT 1;",
  },
  test_select_where_with_function_mixed_args: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `name` = COMMAND(`table`, 'lower') LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `name` = COMMAND(`table`, ?) LIMIT 1;",
  },
  test_select_where_with_nested_function: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `name` = LOWERCASE(UPPERCASE('lower')) LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `name` = LOWERCASE(UPPERCASE(?)) LIMIT 1;",
  },
  test_select_where_like: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` LIKE 'value'",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` LIKE ?",
  },
  test_select_limit_and_offset: {
    unsanitized: "SELECT `table`.* FROM `table` LIMIT 10 OFFSET 5;",
    sanitized:   "SELECT `table`.* FROM `table` LIMIT 10 OFFSET ?;",
  },
  test_select_and_quoted: {
    unsanitized: "SELECT \"table\".* FROM \"table\" WHERE \"field1\" = 1 AND \"field2\" = 'something';",
    sanitized:   "SELECT \"table\".* FROM \"table\" WHERE \"field1\" = ? AND \"field2\" = ?;",
  },
  test_select_between_and: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `field` BETWEEN 5 AND 10;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `field` BETWEEN ? AND ?;",
  },
  test_select_and_with_scope_and_unquoted_field: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` = 1 AND (other_field = 1) LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` = ? AND (other_field = ?) LIMIT 1;",
  },
  test_count_start: {
    unsanitized: "SELECT COUNT(*) FROM `table` WHERE `field` = 1;",
    sanitized:   "SELECT COUNT(*) FROM `table` WHERE `field` = ?;",
  },
  test_select_where_already_placeholder: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` = $1 LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` = $1 LIMIT 1;",
  },
  test_select_where_or_and_operators: {
    unsanitized: "SELECT `posts`.* FROM `posts` WHERE (created_at >= '2016-01-10 13:34:46.647328' OR updated_at >= '2016-01-10 13:34:46.647328')",
    sanitized:   "SELECT `posts`.* FROM `posts` WHERE (created_at >= ? OR updated_at >= ?)",
  },
  test_select_reversed_comparison_operators: {
    unsanitized: "SELECT `posts`.* FROM `posts` WHERE ('2016-01-10' >= created_at AND '2016-01-10' <= updated_at OR '2021-10-22' = published_at)",
    sanitized:   "SELECT `posts`.* FROM `posts` WHERE (? >= created_at AND ? <= updated_at OR ? = published_at)",
  },
  test_bitfield_modifier: {
    unsanitized: "SELECT * FROM `posts` WHERE `field` = x'42'",
    sanitized:   "SELECT * FROM `posts` WHERE `field` = x?",
  },
  test_date_modifier: {
    unsanitized: "SELECT * FROM `posts` WHERE `field` = DATE 'str' AND `field2` = DATE'str'",
    sanitized:   "SELECT * FROM `posts` WHERE `field` = DATE ? AND `field2` = DATE?",
  },
  test_binary_modifier: {
    unsanitized: "SELECT * FROM `posts` WHERE `field` = BINARY '123' and `field2` = BINARY'456' AND `field3` = BINARY 789",
    sanitized:   "SELECT * FROM `posts` WHERE `field` = BINARY ? AND `field2` = BINARY? AND `field3` = BINARY ?",
  },
  test_string_modifier: {
    unsanitized: "SELECT * FROM `posts` WHERE `field` = n'str' AND `field2` = _utf8'str'",
    sanitized:   "SELECT * FROM `posts` WHERE `field` = n? AND `field2` = _utf8?",
  },
  test_select_in: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` IN (1, 2, 3) LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` IN (?) LIMIT 1;",
  },
  test_select_in_subquery: {
    unsanitized: "SELECT `table`.* FROM `table` WHERE `id` IN (SELECT `id` FROM `something` WHERE `a` = 1) LIMIT 1;",
    sanitized:   "SELECT `table`.* FROM `table` WHERE `id` IN (SELECT `id` FROM `something` WHERE `a` = ?) LIMIT 1;",
  },
  test_select_array: {
    unsanitized: "SELECT * FROM \"table\" WHERE \"field\" = ARRAY['item_1','item_2','item_3'];",
    sanitized:   "SELECT * FROM \"table\" WHERE \"field\" = ARRAY[?];",
  },
  test_select_join_backquote_tables: {
    unsanitized: "SELECT * FROM `tables` INNER JOIN `other` ON `table`.`id` = `other`.`table_id` WHERE `other`.`field` = 1);",
    sanitized:   "SELECT * FROM `tables` INNER JOIN `other` ON `table`.`id` = `other`.`table_id` WHERE `other`.`field` = ?);",
  },
  test_select_join_doublequote_tables: {
    unsanitized: "SELECT * FROM \"tables\" INNER JOIN \"other\" ON \"table\".\"id\" = \"other\".\"table_id\" WHERE \"other\".\"field\" = 1);",
    sanitized:   "SELECT * FROM \"tables\" INNER JOIN \"other\" ON \"table\".\"id\" = \"other\".\"table_id\" WHERE \"other\".\"field\" = ?);",
  },
  test_select_with_functions_regex_and_newlines: {
    unsanitized: <<-SQL,
      SELECT a.attname, format_type(a.atttypid, a.atttypmod),
      pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod
      FROM pg_attribute a LEFT JOIN pg_attrdef d
      ON a.attrelid = d.adrelid AND a.attnum = d.adnum
      WHERE a.attrelid = '\"value\"'::regclass
      AND a.attnum > 0 AND NOT a.attisdropped
      ORDER BY a.attnum;
    SQL
    sanitized: <<-SQL,
      SELECT a.attname, format_type(a.atttypid, a.atttypmod),
      pg_get_expr(d.adbin, d.adrelid), a.attnotnull, a.atttypid, a.atttypmod
      FROM pg_attribute a LEFT JOIN pg_attrdef d
      ON a.attrelid = d.adrelid AND a.attnum = d.adnum
      WHERE a.attrelid = ?::regclass
      AND a.attnum > ? AND NOT a.attisdropped
      ORDER BY a.attnum;
    SQL
  },
  test_update_backquote_tables: {
    unsanitized: "UPDATE `table` SET `field` = \"value\", `field2` = 1 WHERE id = 1;",
    sanitized:   "UPDATE `table` SET `field` = ?, `field2` = ? WHERE id = ?;",
  },
  test_update_double_quote_tables: {
    unsanitized: "UPDATE \"table\" SET \"field1\" = 'value', \"field2\" = 1 WHERE id = 1;",
    sanitized:   "UPDATE \"table\" SET \"field1\" = ?, \"field2\" = ? WHERE id = ?;",
  },
  test_insert_backquote_tables: {
    unsanitized: "INSERT INTO `table` (`field1`, `field2`) VALUES ('value', 1, -1.0, 'value');",
    sanitized:   "INSERT INTO `table` (`field1`, `field2`) VALUES (?, ?, ?, ?);",
  },
  test_insert_doublequote_tables: {
    unsanitized: "INSERT INTO \"table\" (\"field1\", \"field2\") VALUES ('value', 1, -1.0, 'value');",
    sanitized:   "INSERT INTO \"table\" (\"field1\", \"field2\") VALUES (?, ?, ?, ?);",
  },
  test_insert_multiple_values: {
    unsanitized: "INSERT INTO `table` (`field1`, `field2`) VALUES ('value', 1, -1.0, 'value'),('value', 1, -1.0, 'value'),('value', 1, -1.0, 'value');",
    sanitized:   "INSERT INTO `table` (`field1`, `field2`) VALUES (?, ?, ?, ?),(?, ?, ?, ?),(?, ?, ?, ?);",
  },
  test_insert_multiple_values_with_spaces: {
    unsanitized: "INSERT INTO `table` (`field1`, `field2`) VALUES ('value', 1, -1.0, 'value'), ('value', 1, -1.0, 'value'), ('value', 1, -1.0, 'value');",
    sanitized:   "INSERT INTO `table` (`field1`, `field2`) VALUES (?, ?, ?, ?), (?, ?, ?, ?), (?, ?, ?, ?);",
  },
  test_insert_returning: {
    unsanitized: "INSERT INTO \"table\" (\"field1\", \"field2\") VALUES ('value', 1) RETURNING \"id\";",
    sanitized:   "INSERT INTO \"table\" (\"field1\", \"field2\") VALUES (?, ?) RETURNING \"id\";",
  },
  test_insert_null: {
    unsanitized: "INSERT INTO \"table\" (\"field1\", \"field2\") VALUES (NULL, 1);",
    sanitized:   "INSERT INTO \"table\" (\"field1\", \"field2\") VALUES (?, ?);",
  },
  test_comment_pound: {
    unsanitized: "SELECT * FROM table # This is a comment",
    sanitized:   "SELECT * FROM table # This is a comment",
  },
  test_comment_double_dash: {
    unsanitized: "SELECT * FROM table -- This is a comment\n SELECT",
    sanitized:   "SELECT * FROM table -- This is a comment\n SELECT",
  },
  test_comment_multi_line: {
    unsanitized: "SELECT * FROM table /* This is a comment */ SELECT",
    sanitized:   "SELECT * FROM table /* This is a comment */ SELECT",
  },
  test_keep_placeholders: {
    unsanitized: "SELECT \"users\".* FROM \"users\" WHERE \"users\".\"type\" IN (?) AND \"users\".\"active\" = $1",
    sanitized:   "SELECT \"users\".* FROM \"users\" WHERE \"users\".\"type\" IN (?) AND \"users\".\"active\" = $1",
  },
  test_json_operations: {
    unsanitized: "SELECT table.*, NULLIF((table2.json_col #>> '{obj1,obj2}')::float, 0) FROM table",
    sanitized:   "SELECT table.*, NULLIF((table2.json_col #>> ?)::float, 0) FROM table",
  },
}

########################################################################################################
# Copied from: https://github.com/open-telemetry/opentelemetry-ruby-contrib/blob/main/instrumentation/mysql2/lib/opentelemetry/instrumentation/mysql2/patches/client.rb
########################################################################################################
COMPONENTS_REGEX_MAP = {
  single_quotes: /'(?:[^']|'')*?(?:\\'.*|'(?!'))/,
  double_quotes: /"(?:[^"]|"")*?(?:\\".*|"(?!"))/,
  numeric_literals: /-?\b(?:[0-9]+\.)?[0-9]+([eE][+-]?[0-9]+)?\b/,
  boolean_literals: /\b(?:true|false|null)\b/i,
  hexadecimal_literals: /0x[0-9a-fA-F]+/,
  comments: /(?:#|--).*?(?=\r|\n|$)/i,
  multi_line_comments: %r{\/\*(?:[^\/]|\/[^*])*?(?:\*\/|\/\*.*)}
}.freeze

MYSQL_COMPONENTS = %i[
  single_quotes
  double_quotes
  numeric_literals
  boolean_literals
  hexadecimal_literals
  comments
  multi_line_comments
].freeze

def obfuscate_sql(sql)
  if sql.size > 2000
    'SQL query too large to remove sensitive data ...'
  else
    obfuscated = sql.gsub(generated_mysql_regex, '?')
    obfuscated = 'Failed to obfuscate SQL query - quote characters remained after obfuscation' if detect_unmatched_pairs(obfuscated)
    obfuscated
  end
end

def generated_mysql_regex
  @generated_mysql_regex ||= Regexp.union(MYSQL_COMPONENTS.map { |component| COMPONENTS_REGEX_MAP[component] })
end

def detect_unmatched_pairs(obfuscated)
  # We use this to check whether the query contains any quote characters
  # after obfuscation. If so, that's a good indication that the original
  # query was malformed, and so our obfuscation can't reliably find
  # literals. In such a case, we'll replace the entire query with a
  # placeholder.
  %r{'|"|\/\*|\*\/}.match(obfuscated)
end
########################################################################################################
