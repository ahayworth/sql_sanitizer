# sql_sanitizer

This is a quick little experiment, trying to sanitize SQL queries through a Rust crate rather than a Ruby regular expression. It's really not intended to be used, or anything - but I thought it was interesting so here you go.

## Installation

I tested against:

- Ruby 3.1.2
- Rust nightly (that's just what my current toolchain was, I don't think nightly is required or anything)

1. Install Ruby
2. Install Rust
3. `bundle`

Running any of the following rake tasks will build the extension as a prerequisite:

- `bundle exec rake test`
- `bundle exec rake bench`
- `bundle exec rake bench_short`

## Tests?

Oh I wrote some, and they're gleefully borrowed from [appsignal/sql_lexer](https://github.com/appsignal/sql_lexer). In addition, I borrowed the mysql sanitization code from [opentelemetry](https://github.com/open-telemetry/opentelemetry-ruby-contrib/blob/main/instrumentation/mysql2/lib/opentelemetry/instrumentation/mysql2/patches/client.rb) (which itself was borrowed from other places).

Run `rake test` to see the results.

Currently, two things stand out to me:
- It _works_, but to be fair this is a really simple wrapper around a rust library and I'm essentially re-using their _own_ test cases ... so maybe that's not surprising to anyone. Although it was kinda cool just to see the whole thing work.
- The SQL statements are _not_ identically sanitized by the opentelemetry code, nor are they sanitized particularly well in many cases. I'm not sure if this is because the SQL dialects are sufficiently different and perhaps this is not a good test at all.

## Benchmarks?

Yup. Run `bundle exec rake bench` (or `bundle exec rake bench_short` if you're in a hurry, to just benchmark a few things quickly).

Interestingly, the opentelemetry sanitization code is _drastically_ faster. I think this could be for a few reasons:
- The opentelemetry code is regex-based, and regular expressions themselves in ruby are not necessarily slow.
- In contrast, the rust code is actually parsing the query and modifying an AST, and that may not be tightly optimized code.
- The rust code also seems to be sanitizing more thoroughly, so it's possible that an equivalent regular expression for Ruby might not be drastically better.
- I'm also not sure about the rust extension interface here ... I have a suspicion that we're actually copying and allocating rust strings and then re-doing the process on the way out, which feels expensive. I think it might be possible to operate directly on the ruby string objects instead, but honestly I'm not that smart.
