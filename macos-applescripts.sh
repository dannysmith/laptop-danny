# Set up Terminal Profile
curl https://raw.githubusercontent.com/dannysmith/laptop-danny/master/assets/DannyPro.terminal > "$HOME/DannyPro.terminal"
open "$HOME/SpartaPro.terminal"
slep 2
osascript <<EOD
  tell application "Terminal"
    set default settings to settings set "SpartaPro"
    activate
  end tell
EOD
