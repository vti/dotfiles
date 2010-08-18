install: vim

vim:
	$(call backup, ~/.vimrc) && ln -s $(PWD)/.vimrc ~/
	touch ~/.vimrcX

backup = \
	if [ -e $(1) ]; then mv $(1) $(addsuffix .bak,$(1)); fi
