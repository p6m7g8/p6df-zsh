# shellcheck shell=zsh
######################################################################
#<
#
# Function: p6df::modules::zsh::version()
#
#>
######################################################################
p6df::modules::zsh::version() { echo "0.0.1" }
######################################################################
#<
#
# Function: p6df::modules::zsh::deps()
#
#>
######################################################################
p6df::modules::zsh::deps()    {
	ModuleDeps=(
		zsh-users/zsh-completions
#		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-autosuggestions

		hlissner/zsh-autopair
		zdharma/history-search-multi-word
		zdharma/fast-syntax-highlighting

		djui/alias-tips
		sorin-ionescu/prezto:modules/history

		robbyrussell/oh-my-zsh:lib/diagnostics
#		jimeh/zsh-peco-history
#		psprint/zsh-navigation-tools
#		psprint/zsh-editing-workbench

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
  brew install zpython
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