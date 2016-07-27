# Set up Terminal Profile

fancy_echo "Installing Terminal Profile..."

curl https://raw.githubusercontent.com/dannysmith/laptop-danny/master/assets/DannyPro.terminal > "$HOME/DannyPro.terminal"
open "$HOME/DannyPro.terminal"
slep 2
osascript <<EOD
  tell application "Terminal"
    set default settings to settings set "DannyPro"
    activate
  end tell
EOD

green_echo "Done with applescripts!"
