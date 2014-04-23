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

_zsh_user() {
    if [[ ! -r ~/.zsh-main-user ]] ; then
        if [[ -r ~/.zsh-main-host ]] ; then
            # No 'host' field so we need to add the colon here
            echo "%n:"
        else
            echo "%n"
        fi
    fi
}

_zsh_host() {
    if [[ ! -r ~/.zsh-main-host ]] ; then
        echo "@%m:"
    fi
}

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

PROMPT='%{$fg[cyan]%}[$(_zsh_user)$(_zsh_host)%~% ]%(?.%{$fg[green]%}.%{$fg[red]%})%B$%b '
