# Set faster Key Repeat
defaults write -g KeyRepeat -int 0

# Disable press-and-hold and enable KeyRepeat instead
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable Gatekeepr - http://osxdaily.com/2015/05/04/disable-gatekeeper-command-line-mac-osx/
echo $passwd | sudo -S -k spctl --master-disable
# Disable System Integrity Protection (rootless)
echo $passwd | sudo -S -k csrutil disable

