cd ~
ln -sf ./dotfiles/.lynxrc .
ln -sf ./dotfiles/.tmux.conf .
ln -sf ./dotfiles/.zshrc .
ln -sf ./dotfiles/.eslintrc.json .
mkdir -p ~/.config/nvim
cd ~/.config/nvim 
ln -sf ../../dotfiles/init.vim .
mkdir -p ~/.config/ranger
cd ~/.config/ranger 
ln -sf ../../dotfiles/rc.conf .
mkdir -p ~/.config/i3
cd ~/.config/i3 
ln -sf ../../dotfiles/config .
