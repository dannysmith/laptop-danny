echo "Installing Vim Plugins..."
curl -fLo "$HOME/.vim/autoload/plug.vim" --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
fancy_echo "Running VimPlug Commands..."

vim :silent! +PlugInstall +qall
vim :silent! +PlugClean +qall

green_echo "Done with Vim config!"
