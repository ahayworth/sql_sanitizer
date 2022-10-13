use magnus::{define_global_function, function};
use sql_lexer;

fn sanitize_sql(sql: String) -> String {
    sql_lexer::sanitize_string(sql)
}

#[magnus::init]
fn init() {
    define_global_function("sanitize_sql", function!(sanitize_sql, 1));
}
