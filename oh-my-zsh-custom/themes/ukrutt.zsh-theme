ZSH_THEME_GIT_PROMPT_PREFIX="%{$reset_color%}%{$fg[green]%}["
ZSH_THEME_GIT_PROMPT_SUFFIX="]%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%}*%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_CLEAN=""

#Customized git status, oh-my-zsh currently does not allow render dirty status before branch
git_custom_status() {
  local cb=$(current_branch)
  if [ -n "$cb" ]; then
    echo "$(parse_git_dirty)%{$fg_bold[yellow]%}$(work_in_progress)%{$reset_color%}$ZSH_THEME_GIT_PROMPT_PREFIX$(current_branch)$ZSH_THEME_GIT_PROMPT_SUFFIX"
  fi
}

# Check this out: If there is a file named '~/.zsh-main-user' in your
# home directory (it doesn't need to contain anything) then your user
# name WON'T be printed.
if [[ ! -r ~/.zsh-main-user ]] ; then
    if [[ -r ~/.zsh-main-host ]] ; then
        # No 'host' field so we need to add the colon here
        _ZSH_USER="$fg[yellow]%n$fg[default]:$fg[cyan]"
    else
        _ZSH_USER="$fg[yellow]%n"
    fi
fi
# Similar for the file '~/.zsh-main-host'.
if [[ ! -r ~/.zsh-main-host ]] ; then
    _ZSH_HOST="$fg[default]@$fg[yellow]%m$fg[default]:$fg[cyan]"
fi


#RVM and git settings
if [[ -s ~/.rvm/scripts/rvm ]] ; then
  RPS1='$(git_custom_status)%{$fg[red]%}[`~/.rvm/bin/rvm-prompt`]%{$reset_color%} $EPS1'
else
  if which rbenv &> /dev/null; then
    RPS1='$(git_custom_status)%{$fg[red]%}[`rbenv version | sed -e "s/ (set.*$//"`]%{$reset_color%} $EPS1'
  else
    if [[ -n `which chruby_prompt_info` && -n `chruby_prompt_info` ]]; then
      RPS1='$(git_custom_status)%{$fg[red]%}[`chruby_prompt_info`]%{$reset_color%} $EPS1'
    else
      if type "virtualenv_prompt_info" > /dev/null ; then
        RPS1='$(virtualenv_prompt_info)$(git_custom_status)$EPS1'
      else
        RPS1='$(git_custom_status) $EPS1'
      fi
    fi
  fi
fi

PROMPT='%{$fg[cyan]%}[${_ZSH_USER}${_ZSH_HOST}%2~% ]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
