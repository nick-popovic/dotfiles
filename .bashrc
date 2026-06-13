#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias lg='lazygit'

PS1='[\u@\h \W]\$ '


export EDITOR="nvim"
export PATH="$PATH:$(go env GOPATH)/bin"

eval "$(starship init bash)"

# -----------------------------------------------------------------------------
# TMUX SMART LAUNCHER (requires fzf)
# -----------------------------------------------------------------------------
# Overrides the 'tmux' command to provide an interactive session picker.
# 
# Usage:
#   tmux           - Opens the interactive menu
#   tmux <args>    - Runs standard tmux commands (e.g., 'tmux ls')
#
# Shortcuts in Menu:
#   [Enter]        - Join the highlighted session
#   [a]            - Create a new unnamed/numbered session
#   [n]            - Create a new session with a custom name
#   [d]            - Delete (kill) the highlighted session
#   [k]            - Kill ALL active sessions (requires confirmation)
#   [ESC]          - Exit the menu and return to shell prompt
# -----------------------------------------------------------------------------
tmux() {
    # If arguments are provided (e.g., 'tmux ls'), run the actual command
    if [ "$#" -gt 0 ]; then
        command tmux "$@"
        return
    fi

    while true; do
        # Get sessions, or an empty string if none exist
        local sessions
        sessions=$(command tmux ls 2>/dev/null)

        # Prepare the list for fzf
        local display_list
        if [[ -z "$sessions" ]]; then
            display_list="--- No Active Sessions ---"
        else
            display_list="$sessions"
        fi

        local out
        local header="[Enter]: Join | [a]: New | [n]: Named | [d]: Delete | [k]: Kill All | [ESC]: Abort"
        
        # Launch fzf
        out=$(echo "$display_list" | fzf --header="$header" \
            --height=15% --reverse --info=inline \
            --expect=a,n,k,d)

        local key=$(echo "$out" | head -1)
        local selection=$(echo "$out" | sed -n '2p')

        case "$key" in
            a)
                command tmux new-session
                return
                ;;
            n)
                read -p "Enter session name: " name
                if [[ -z "$name" ]]; then
                    command tmux new-session
                else
                    command tmux new-session -s "$name"
                fi
                return
                ;;
            k)
                if [[ -n "$sessions" ]]; then
                    read -p "Are you sure you want to kill ALL sessions? (y/n): " confirm
                    if [[ "$confirm" == [yY] ]]; then
                        command tmux kill-server
                        # Continue loop to update display
                    fi
                fi
                ;;
            d)
                # Ensure we aren't trying to delete the placeholder text
                if [[ -n "$selection" && "$selection" != "--- No Active Sessions ---" ]]; then
                    local target=$(echo "$selection" | cut -d: -f1)
                    command tmux kill-session -t "$target"
                fi
                ;;
            *)
                # If Enter was pressed on a valid session
                if [[ -n "$selection" && "$selection" != "--- No Active Sessions ---" ]]; then
                    local target=$(echo "$selection" | cut -d: -f1)
                    command tmux attach-session -t "$target"
                    return
                else
                    # User hit ESC, or Enter on the placeholder
                    return
                fi
                ;;
        esac
    done
}

# SSH Agent Setup
export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/ssh-agent.socket"
if [ ! -S "$SSH_AUTH_SOCK" ]; then
    eval "$(ssh-agent -a "$SSH_AUTH_SOCK")" > /dev/null
fi
ssh-add -l > /dev/null 2>&1 || ssh-add ~/.ssh/id_ed25519 2>/dev/null


# Added by Antigravity CLI installer
export PATH="/home/nick/.local/bin:$PATH"
export PATH="/home/nick/.local/bin:$PATH"
