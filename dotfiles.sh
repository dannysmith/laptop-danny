# Install dotfiles
fancy_echo "Installing dotfiles..."
git clone $dotfiles_repo $HOME/.dotfiles
echo "Symlinking with thoughtbot/rcup..."
cd $HOME && rcup

green_echo "Done with dotfiles install!"
