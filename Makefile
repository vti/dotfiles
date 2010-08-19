all: vim zsh

vim:
	$(call safeln,.vimrc,~/.vimrc)
	rm -f ~/.vim-dotfiles && ln -s $(PWD)/.vim ~/.vim-dotfiles
	touch ~/.vimrcX

zsh:
	$(call safeln,.zshrc,~/.zshrc)
	touch ~/.zshrcX

safeln = \
	$(call saferm,$(2));   \
	ln -s $(PWD)/$(1) $(2)

saferm =                                \
	if [ -L $(1) ]; then                \
		rm $(1);                        \
	elif [ -e $(1) ]; then              \
		mv $(1) $(addsuffix .bak,$(1)); \
	fi
