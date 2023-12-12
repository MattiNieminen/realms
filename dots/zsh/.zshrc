# Aliases
alias ls='ls --color=auto'

# Autocomplete
autoload -U +X bashcompinit && bashcompinit

autoload -Uz compinit
for dump in ~/.zcompdump(N.mh+24); do
  compinit
done
compinit -C

# History
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt append_history
setopt inc_append_history
setopt hist_expire_dups_first
unsetopt hist_save_by_copy

# Misc
setopt interactive_comments

# Pure-prompt
fpath+=$HOME/.zsh/pure
autoload -U promptinit; promptinit
prompt pure
