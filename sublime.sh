fancy_echo "Cloning Sublime packages repo"

git clone $sublime_packages_repo "$HOME/Library/Application Support/Sublime Text 3/Packages/User"

# TODO
# Run `subl --command <stuff>` to configure packages properly.

green_echo "Done with Sublime Text config!"
