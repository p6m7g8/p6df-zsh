# shellcheck shell=zsh

######################################################################
#<
#
# Function: p6df::modules::zsh::deps()
#
#>
######################################################################
p6df::modules::zsh::deps() {
	ModuleDeps=(
    p6m7g8/p6common

		zsh-users/zsh-completions
		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-autosuggestions

		hlissner/zsh-autopair
		zdharma/history-search-multi-word
		zdharma/fast-syntax-highlighting

		djui/alias-tips
		sorin-ionescu/prezto:modules/history

		ohmyzsh/ohmyzsh:lib/diagnostics
		# jimeh/zsh-peco-history
		psprint/zsh-navigation-tools
		psprint/zsh-editing-workbench

		zplug/zplug
	)
}

######################################################################
#<
#
# Function: p6df::modules::zsh::external::brew()
#
#>
######################################################################
p6df::modules::zsh::external::brew() {

  brew install zsh
  brew install zmap
  brew install zshdb
  brew install zssh
  brew install zsync
}

######################################################################
#<
#
# Function: p6df::modules::zsh::home::symlink()
#
#>
######################################################################
p6df::modules::zsh::home::symlink() {

  # XXX: .zshenv .zshrc here or there?
}

######################################################################
#<
#
# Function: p6df::modules::zsh::init()
#
#>
######################################################################
p6df::modules::zsh::init() {

  p6df::util::cdpath::if "$P6_DFZ_SRC_DIR/ohmyzsh/ohmyzsh/plugins"
  p6df::modules::zsh::hooks::init
  p6df::modules::zsh::colors::init
  p6df::modules::zsh::comp::init
}

######################################################################
#<
#
# Function: p6df::modules::zsh::hooks::init()
#
#>
######################################################################
p6df::modules::zsh::hooks::init() {

  autoload -Uz add-zsh-hook
}

######################################################################
#<
#
# Function: p6df::modules::zsh::colors::init()
#
#>
######################################################################
p6df::modules::zsh::colors::init() {

  autoload -U colors && colors
}

######################################################################
#<
#
# Function: p6df::modules::zsh::comp::init()
#
#>
######################################################################
p6df::modules::zsh::comp::init() {``

  autoload -U compaudit compinit
  compaudit
  compinit -i -d ${ZDOTDIR}/.zcompdump
}

######################################################################
#<
#
# Function: p6df::modules::zsh::off()
#
#>
######################################################################
p6df::modules::zsh::off() {

  p6_file_unlink "${ZDOTDIR}/.zshrc"
  p6_file_unlink "${ZDOTDIR}/.zshenv"
  p6_file_create "${ZDOTDIR}/.zshrc"

}

######################################################################
#<
#
# Function: p6df::modules::zsh::on()
#
#>
######################################################################
p6df::modules::zsh::on() {

  p6_file_remove "${ZDOTDIR}/.zshrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zshrc" "${ZDOTDIR}/.zshrc"
  p6_file_symlink "$P6_DFZ_SRC_P6M7G8_DIR/p6df-core/conf/zshenv" "${ZDOTDIR}/.zshenv"
}

######################################################################
#<
#
# Function: p6df::modules::zsh::reload()
#
#>
######################################################################
p6df::modules::zsh::reload() {

  local pair 
  for pair in $(p6_env_list | grep -Ev "^PATH=|P6_DFZ_MODULES|MYSQL_PS1"); do
    local k=$(echo $pair | awk -F= '{print $1}')
    p6_env_export_un "$k"
  done

  exec zsh -li
}

######################################################################
#<
#
# Function: str info = p6df::modules::zsh::prompt::std()
#
#  Returns:
#	str - info
#
#>
######################################################################
p6df::modules::zsh::prompt::std() {

  local tty=$fg[cyan]%l$reset_color
  local user=$fg[blue]%n$reset_color
  local host=$fg[yellow]%M$reset_color

  local info="[$tty]$user@$host rv=%?"

  p6_return_str "$info"
}

######################################################################
#<
#
# Function: str dir = p6df::modules::zsh::prompt::dir()
#
#  Returns:
#	str - dir
#
#>
######################################################################
p6df::modules::zsh::prompt::dir() {

  local dir=$fg[green]%/$reset_color

  p6_return_str "$dir"
}