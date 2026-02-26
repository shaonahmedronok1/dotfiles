# ~/.bashrc

[[ $- != *i* ]] && return

# === THE DEFINITIVE RUSTY HISTORY PROTOCOL (10/10 PERFECTION) ===
export HISTCONTROL=ignoreboth:erasedups
export HISTSIZE=100000
export HISTFILESIZE=100000
export HISTTIMEFORMAT="%Y-%m-%d %H:%M:%S  "
shopt -s histappend
shopt -s cmdhist

# Syncs all Alacritty windows instantly
PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"

# 1. Wrapped Stats
wrapped() {
  echo -e "\n\033[1;33m  󱆟 YOUR TOP 20 COMMANDS (2026)\033[0m"
  echo -e "\033[1;30m  ──────────────────────────────\033[0m"
  history | awk '{CMD[$4]++}END { for (a in CMD)print CMD[a] " " a }' | sort -nr | head -n 20 | column -t | sed 's/^/   /'
  echo ""
}

# 2. Skim Search: Newest at Top + No Re-sorting Trash
h() {
  tput smcup
  local selected_command
  # tac reverses history; --no-sort ensures Skim doesn't ruin the order
  selected_command=$(history | tac | sk --height 100% --layout=reverse --ansi --no-sort \
    --header=" 🦀 RECENT HISTORY FIRST [Enter to Run] " \
    --color="bg:#f5f0e8,fg:#0a0a0a,matched:#3d5a7a,current_bg:#d1ccc4,current_fg:#0a0a0a,cursor:#b23b3b,prompt:#a57e1a,header:#a57e1a" \
    --query="$READLINE_LINE")
  tput rmcup

  if [[ -n "$selected_command" ]]; then
    # Professional sed to strip Bangladesh timestamps
    local clean_cmd=$(echo "$selected_command" | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+[0-9]{4}-[0-9]{2}-[0-9]{2}[[:space:]]+[0-9]{2}:[0-9]{2}:[0-9]{2}[[:space:]]+//')
    READLINE_LINE="$clean_cmd"
    READLINE_POINT=${#clean_cmd}
  fi
}

# Keybindings
bind -x '"\C-h": h'
bind '"\e[A": history-search-backward'
bind '"\e[B": history-search-forward'

# Shell improvements
shopt -s autocd       # Type 'Downloads' instead of 'cd Downloads'
shopt -s cdspell      # Fix typos: 'cd Donwloads' works
shopt -s cmdhist      # Multi-line commands saved as one
shopt -s checkwinsize # Update terminal size
bind "set completion-ignore-case on"
bind "set show-all-if-ambiguous on"      # Show completions immediately
bind "set mark-symlinked-directories on" # Mark symlinked dirs with /
bind "set colored-stats on"              # Color completion by file type
bind "set visible-stats on"              # Show file type indicators

ex() {
  [ -z "$1" ] && echo "Usage: ex <file>" && return 1
  case "$1" in
  *.tar.bz2 | *.tbz2) tar xvjf "$1" ;;
  *.tar.gz | *.tgz) tar xvzf "$1" ;;
  *.tar.xz | *.txz) tar xvJf "$1" ;;
  *.zip) unzip "$1" ;;
  *.7z) 7z x "$1" ;;
  *.gz) gunzip "$1" ;;
  *.bz2) bunzip2 "$1" ;;
  *) echo "Unknown format" ;;
  esac
}

case ${TERM} in
ghostty | xterm-256color)
  PROMPT_COMMAND='echo -ne "\033]0;${USER}@${HOSTNAME}:${PWD/#$HOME/\~}\007"'
  ;;
esac

### ALIASES ###

# pacman and yay
alias unlock='sudo rm /var/lib/pacman/db.lck'   # remove pacman lock
alias orphan='sudo pacman -Rns $(pacman -Qtdq)' # remove orphaned packages (DANGEROUS!)

# confirmation of created dir
alias mkdir='mkdir -pv'

# FILE VIEWING & NAVIGATION

# get fastest mirrors
alias mirror="sudo reflector -f 30 -l 30 --number 10 --verbose --save /etc/pacman.d/mirrorlist"
alias mirrord="sudo reflector --latest 50 --number 20 --sort delay --save /etc/pacman.d/mirrorlist"
alias mirrors="sudo reflector --latest 50 --number 20 --sort score --save /etc/pacman.d/mirrorlist"
alias mirrora="sudo reflector --latest 50 --number 20 --sort age --save /etc/pacman.d/mirrorlist"

# adding flags
alias df='df -h'               # human-readable sizes
alias free='free -m'           # show sizes in MB
alias grep='grep --color=auto' # colorize output (good for log files)

# bigger font in tty and regular font in tty
alias bigfont="setfont ter-132b"
alias regfont="setfont default8x16"

# ===============================
# Terminal-Only Workflow Aliases
# ===============================

# Quick archive operations
alias tgz='tar -czf'
alias tgx='tar -xzf'
alias tbz='tar -cjf'
alias tbx='tar -xjf'
alias txz='tar -cJf'
alias txx='tar -xJf'

# List all aliases
alias aliases='alias | bat --language=bash'

# Show largest directories in current location
alias big='du -h --max-depth=1 | sort -h | tail -20'

# System info shortcuts
alias mem='free -h'
alias disk='df -h'
alias cpu='lscpu'
alias temp='sensors' # If lm_sensors installed

# Quick file operations
alias cpv='rsync -avh --progress'                       # Copy with progress
alias mvv='rsync -avh --progress --remove-source-files' # Move with progress

export PATH="$HOME/bin:$PATH"

export PATH="$HOME/.config/doom/bin:$PATH"

export YAZI_FILE_ONE_IGNORES="*~:*.bak:*.swp:*.tmp"

# ===============================
# Functions
# ===============================

# yazi with cwd on exit (official yazi example)
ya() {
  local tmp="$(mktemp)"
  yazi "$@" --cwd-file="$tmp"
  if [ -f "$tmp" ]; then
    cd "$(cat "$tmp")" || return
    rm -f "$tmp"
  fi
}

# ===============================
# Advanced File Management Functions
# ===============================

# FZF file selector with preview
ff() {
  local file
  file=$(fd --type f --hidden --exclude .git | fzf --preview 'bat --color=always --style=numbers --line-range=:500 {}') && nvim "$file"
}

# FZF process killer
fkill() {
  local pid
  pid=$(ps -ef | sed 1d | fzf -m --header='[kill process]' | awk '{print $2}')
  if [ -n "$pid" ]; then
    echo "$pid" | xargs kill -${1:-9}
  fi
}

# Ripgrep + FZF file search
rgf() {
  if [ -z "$1" ]; then
    echo "Usage: rgf <search_pattern>"
    return 1
  fi
  local file
  file=$(rg --files-with-matches --no-messages "$1" | fzf --preview "rg --color=always --context 10 '$1' {}") && nvim "$file"
}

# Quick file preview
prev() {
  if [ -z "$1" ]; then
    echo "Usage: prev <file>"
    return 1
  fi
  if [ ! -f "$1" ]; then
    echo "Not a file: $1"
    return 1
  fi
  case "$1" in
  *.jpg | *.jpeg | *.png | *.gif | *.bmp | *.webp) imv "$1" ;;
  *.mp4 | *.mkv | *.avi | *.mov | *.webm | *.flv) mpv "$1" ;;
  *.pdf) zathura "$1" ;;
  *.md | *.txt | *.log) bat "$1" ;;
  *) bat "$1" ;;
  esac
}

# Quick file operations with confirmation
rmi() {
  fd --type f | fzf -m --header='Select files to DELETE (TAB for multi-select)' | xargs -I {} rm -iv {}
}

cpi() {
  local dest="${1:-.}"
  fd --type f | fzf -m --header='Select files to COPY (TAB for multi-select)' | xargs -I {} cp -v {} "$dest"
}

mvi() {
  local dest="${1:-.}"
  fd --type f | fzf -m --header='Select files to MOVE (TAB for multi-select)' | xargs -I {} mv -v {} "$dest"
}

# Quick file comparison
diffz() {
  diff -u <(bat -p "$1") <(bat -p "$2") | bat --language=diff
}

# Quick git add + commit + push
gac() {
  git add . && git commit -m "${1:-quick update}" && git push
}

# Quick find and replace preview (safe)
rep() {
  if [ $# -ne 2 ]; then
    echo "Usage: rep 'old' 'new'"
    return 1
  fi
  echo "Preview of changes:"
  rg "$1" --color=always -C 2
  read -p "Apply changes? (y/N) " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    rg --files-with-matches "$1" | xargs sed -i "s/$1/$2/g"
    echo "✓ Replaced '$1' with '$2'"
  fi
}

# Count lines of code
loc() {
  fd --type f -e py -e js -e html -e css -e rs -e c -e cpp -e h | xargs wc -l | sort -rn | head -20 | bat --language=txt
}

# Open multiple files in nvim tabs
vf() {
  fd --type f | fzf -m --header='Select files to open in nvim (TAB for multi)' | xargs -o nvim -p
}

# Safe file operations (terminal-only workflow)
trash() {
  trash-put "$@"
}

# Count files by extension
fcount() {
  fd --type f | sed 's/.*\.//' | sort | uniq -c | sort -rn | head -20
}

# Quick file stats
fstat() {
  if [ -z "$1" ]; then
    echo "Usage: fstat <file_or_dir>"
    return 1
  fi
  echo "=== File/Directory Information ==="
  file "$1"
  stat "$1"
  if [ -d "$1" ]; then
    echo ""
    echo "=== Directory Size ==="
    du -sh "$1"
    echo ""
    echo "=== File Count ==="
    fd --type f . "$1" | wc -l
  fi
}

PS1='\w$(git rev-parse --abbrev-ref HEAD 2>/dev/null | sed "/./s/^/  /") \$ '
eval "$(starship init bash)"
