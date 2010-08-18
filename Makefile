install: vim zsh

vim:
	$(call backup, ~/.vimrc) && ln -s $(PWD)/.vimrc ~/
	touch ~/.vimrcX

zsh:
	$(call backup, ~/.zshrc) && ln -s $(PWD)/.zshrc ~/
	touch ~/.zshrcX

backup = \
	if [ -e $(1) ]; then mv $(1) $(addsuffix .bak,$(1)); fi
