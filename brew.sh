# Create Homebrew dir
fancy_echo "Creating ~/.bin folder..."
if [ ! -d "$HOME/.bin/" ]; then
  mkdir "$HOME/.bin"
fi

green_echo "done."

fancy_echo "Fixing up permissions..."

# Sort Permissions
HOMEBREW_PREFIX="/usr/local"

if [ -d "$HOMEBREW_PREFIX" ]; then
  if ! [ -r "$HOMEBREW_PREFIX" ]; then
    green_echo "Chowning $HOMEBREW_PREFIX to \"$LOGNAME:admin\"..."
    echo $passwd | sudo -S -k chown -R "$LOGNAME:admin" /usr/local
  fi
else
  echo $passwd | sudo -S -k mkdir "$HOMEBREW_PREFIX"
  echo $passwd | sudo -S -k chflags norestricted "$HOMEBREW_PREFIX"
  echo $passwd | sudo -S -k chown -R "$LOGNAME:admin" "$HOMEBREW_PREFIX"
fi

fancy_echo "Checking for homebrew..."
# Install homebrew
if ! command -v brew >/dev/null; then
  fancy_echo "Installing Homebrew ..."
    curl -fsS \
      'https://raw.githubusercontent.com/Homebrew/install/master/install' | ruby

    export PATH="/usr/local/bin:$PATH"
fi

green_echo "done."

# Remove old Homebrew Cask, if it exists.
if brew list | grep -Fq brew-cask; then
  fancy_echo "Uninstalling old Homebrew-Cask..."
  brew uninstall --force brew-cask
  brew cleanup
  green_echo "done."
fi

fancy_echo "Updating homebew and installing packages..."
# Update Homebrew
brew update

# Tap bre-bundle
brew tap Homebrew/bundle

# Install everything in Brewfile
brew bundle

green_echo "done."

fancy_echo "Cleaning up..."
# Clear Up
brew prune
brew cleanup
brew cask cleanup
brew doctor

green_echo "done."

green_echo "Done with homebrew installs!"
