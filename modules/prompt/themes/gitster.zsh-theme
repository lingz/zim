#
# Gitster theme
# https://github.com/shashankmehta/dotfiles/blob/master/thesetup/zsh/.oh-my-zsh/custom/themes/gitster.zsh-theme
#

gst_get_host() {
  if [[ ${USER} != ${DEFAULT_USER} || -n ${SSH_CONNECTION} ]]; then
    print "%F{green}%n@%m"
  fi
}

gst_get_status() {
  print "%(?:%F{white}$:%F{red}$)"
}

gst_get_pwd() {
  prompt_short_dir="$(short_pwd)"
  git_root="$(command git rev-parse --show-toplevel 2> /dev/null)" && \
  prompt_short_dir="${prompt_short_dir#${$(short_pwd $git_root):h}/}"
  print ${prompt_short_dir}
}

prompt_gitster_precmd() {
  PROMPT='$(gst_get_host) %F{blue}$(gst_get_pwd) $(git_prompt_info)%F{white}$ '
}

prompt_gitster_setup() {
  ZSH_THEME_GIT_PROMPT_PREFIX="%F{yellow}"
  ZSH_THEME_GIT_PROMPT_SUFFIX=" %f"
  ZSH_THEME_GIT_PROMPT_DIRTY=" %F{cyan}✗%f"
  ZSH_THEME_GIT_PROMPT_CLEAN=" %F{green}✓%f"

  autoload -Uz add-zsh-hook

  # add-zsh-hook precmd prompt_gitster_precmd
  prompt_gitster_precmd
  prompt_opts=(cr subst percent)
}

prompt_gitster_setup "$@"
