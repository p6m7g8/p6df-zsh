p6df::modules::zsh::version() { echo "0.0.1" }
p6df::modules::zsh::deps()    { 
	ModuleDeps=(
		zsh-users/zsh-completions
#		zsh-users/zsh-syntax-highlighting
		zsh-users/zsh-history-substring-search
		zsh-users/zsh-autosuggestions

		hlissner/zsh-autopair
		zdharma/history-search-multi-word
		zdharma/fast-syntax-highlighting

		sorin-ionescu/prezto:modules/history

#		jimeh/zsh-peco-history
#		psprint/zsh-navigation-tools
#		psprint/zsh-editing-workbench
	)
}

p6df::modules::zsh::external::() {

  brew install zsh
}

p6df::modules::zsh::init() {

  p6df::modules::zsh::colors::init
}

p6df::modules::zsh::colors::init() {

  autoload -U colors && colors
}

p6df::modules::zsh::init
