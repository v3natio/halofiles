# better defaults:
setopt autocd # auto cd into directory.
setopt nomatch # output error if file doesn't match
setopt interactive_comments # comments in interactive shells
stty stop undef # disable ctrl-s to freeze terminal.
zle_highlight=('paste:none') # don't highlight paste

# history in cache directory:
HISTSIZE=5000
SAVEHIST=$HISTSIZE
HISTFILE="${XDG_CACHE_HOME}/zsh/history"
setopt appendhistory
setopt sharehistory
setopt hist_ignore_all_dups
setopt hist_find_no_dups

# load aliases, prompt, functions, etc:
[ -f "${XDG_CONFIG_HOME}/shell/aliasrc" ] && source "${XDG_CONFIG_HOME}/shell/aliasrc"
[ -f "$ZDOTDIR/zsh-prompt" ] && source "$ZDOTDIR/zsh-prompt"
[ -f "$ZDOTDIR/zsh-functions" ] && source "$ZDOTDIR/zsh-functions"
[ -f "/usr/share/fzf/completion.zsh" ] && source "/usr/share/fzf/completion.zsh"
[ -f "/usr/share/fzf/key-bindings.zsh" ] && source "/usr/share/fzf/key-bindings.zsh"

# basic auto/tab complete:
autoload -U compinit && compinit
zstyle ':completion:*' menu no
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}' 
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color=auto $realpath'
zmodload zsh/complist
_comp_options+=(globdots) # include hidden files.

# vim mode:
bindkey -v
export KEYTIMEOUT=1
bindkey -M menuselect 'h' vi-backward-char
bindkey -M menuselect 'k' vi-up-line-or-history
bindkey -M menuselect 'l' vi-forward-char
bindkey -M menuselect 'j' vi-down-line-or-history
bindkey -v '^?' backward-delete-char

# change cursor shape for different vi modes:
zle-keymap-select () {
  case $KEYMAP in
    vicmd) echo -ne '\e[1 q';; # block in command mode
    viins|main) echo -ne '\e[5 q';; # beam in insert mode
  esac
}
zle-line-init() {
  echo -ne '\e[5 q'
}
zle -N zle-keymap-select
zle -N zle-line-init
zle-line-init # beam shape on startup
preexec() { echo -ne '\e[5 q' } # beam shape on new prompt

# move between directories using yazi with ctrl-g:
lfcd() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")"
	yazi "$@" --cwd-file="$tmp"
	if cwd="$(cat -- "$tmp")" && [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
		builtin cd -- "$cwd"
	fi
	rm -f -- "$tmp" >/dev/null 2>&1
}
bindkey -s '^g' '^ulfcd\n'
bindkey -s '^f' '^ucd "$(dirname "$(rg --files | fzf)")"\n' # fuzzy find with ctrl-f
bindkey '^[[P' delete-char

# edit line in vim with ctrl-e:
autoload edit-command-line; zle -N edit-command-line
bindkey '^e' edit-command-line
bindkey -M vicmd '^[[P' vi-delete-char
bindkey -M vicmd '^e' edit-command-line
bindkey -M visual '^[[P' vi-delete

# plugins
zsh_add_plugin "zsh-users/zsh-autosuggestions"
zsh_add_plugin "zdharma-continuum/fast-syntax-highlighting"
zsh_add_plugin "hlissner/zsh-autopair"
zsh_add_plugin "Aloxaf/fzf-tab"
#zsh_add_plugin "darvid/zsh-poetry"
