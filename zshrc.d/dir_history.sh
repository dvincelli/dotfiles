# Create or update SQLite database and table
function create_db {
  sqlite3 ~/.dir_history.db "CREATE TABLE IF NOT EXISTS history (
    id INTEGER PRIMARY KEY,
    dir TEXT UNIQUE,
    count INTEGER DEFAULT 1,
    last_accessed DATETIME DEFAULT (datetime('now','localtime'))
  );"
}

function log_dir_change {
  # Insert or update directory entry with current datetime
  sqlite3 ~/.dir_history.db "INSERT INTO history (dir, last_accessed) VALUES ('$PWD', datetime('now','localtime')) ON CONFLICT(dir) DO UPDATE SET count = count + 1, last_accessed = datetime('now','localtime');"
}

function mru {
  local dir
  dir=$(sqlite3 ~/.dir_history.db "SELECT dir FROM history ORDER BY last_accessed DESC LIMIT 1000;" | fzf --height 40% --reverse) && cd "$dir"
}

function mfu {
  local dir
  dir=$(sqlite3 ~/.dir_history.db "SELECT dir FROM history ORDER BY count DESC, last_accessed DESC LIMIT 1000;" | fzf --height 40% --reverse) && cd "$dir"
}

autoload -U add-zsh-hook
add-zsh-hook chpwd log_dir_change

[ -f ~/.dir_history.db ] || create_db  # Ensure the database is ready
