all: vim zsh

vim:
	$(call backup, ~/.vimrc) && ln -s $(PWD)/.vimrc ~/
	rm -f ~/.vim-dotfiles && ln -s $(PWD)/.vim ~/.vim-dotfiles
	touch ~/.vimrcX

zsh:
	$(call backup, ~/.zshrc) && ln -s $(PWD)/.zshrc ~/
	touch ~/.zshrcX

backup = \
	if [ -e $(1) ]; then mv $(1) $(addsuffix .bak,$(1)); fi
