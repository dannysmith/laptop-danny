
EMAIL='hi@danny.is'

# Set faster Key Repeat
defaults write -g KeyRepeat -int 0

# Disable press-and-hold and enable KeyRepeat instead
defaults write -g ApplePressAndHoldEnabled -bool false

# Disable Gatekeepr - http://osxdaily.com/2015/05/04/disable-gatekeeper-command-line-mac-osx/
echo $passwd | sudo -S -k spctl --master-disable
# Disable System Integrity Protection (rootless)
echo $passwd | sudo -S -k csrutil disable

# Set Profile Picture
fancy_echo "Fetching Gravatar..."
HASH=`echo -n $EMAIL | awk '{print tolower($0)}' | tr -d '\n ' | md5sum --text | tr -d '\- '`
URL="http://www.gravatar.com/avatar/$HASH?s=512&d=404"
curl -s $URL > $HOME/Pictures/avatar.jpg

fancy_echo "Setting Profile Image..."
echo "0x0A 0x5C 0x3A 0x2C dsRecTypeStandard:Users 4 dsAttrTypeStandard:RecordName externalbinary:dsAttrTypeStandard:JPEGPhoto dsAttrTypeStandard:UniqueID dsAttrTypeStandard:PrimaryGroupID dsAttrTypeStandard:GeneratedUID" > $HOME/avatar_import.txt
echo $USER:$HOME/Pictures/avatar.jpg:$UID:$(id -g):$(dscl . -read /Users/$USER GeneratedUID | cut -d' ' -f2) >> $HOME/avatar_import.txt
echo $passwd | sudo -S -k dscl . -delete /Users/$USER JPEGPhoto
echo $passwd | sudo -S -k dsimport $HOME/avatar_import.txt /Local/Default M -u diradmin
rm -f $HOME/avatar_import.txt

fancy_echo "Adding Terminal to allowed assistive devices..."
# Install tccutil and add terminal to list of allowed assistive devices
curl -Os https://raw.githubusercontent.com/jacobsalmela/tccutil/master/tccutil.py
echo $passwd | sudo -S -k python ./tccutil.py --verbose --insert com.apple.Terminal

fancy_echo "Installing MySQL Workbench..."
temp=$TMPDIR$(uuidgen)
mkdir -p $temp/mount
curl -s http://cdn.mysql.com//Downloads/MySQLGUITools/mysql-workbench-community-6.3.7-osx-x86_64.dmg > $temp/1.dmg
yes | hdiutil attach -noverify -nobrowse -mountpoint $temp/mount $temp/1.dmg
cp -r $temp/mount/*.app /Applications
hdiutil detach $temp/mount
rm -rf $temp

# Configure Dock
fancy_echo "Configuring dock..."
/usr/libexec/PlistBuddy -c "Add :magnification bool true" ~/Library/Preferences/com.apple.dock.plist
/usr/libexec/PlistBuddy -c "Add :autohide bool true" ~/Library/Preferences/com.apple.dock.plist
/usr/libexec/PlistBuddy -c "Delete :persistent-apps" ~/Library/Preferences/com.apple.dock.plist
/usr/libexec/PlistBuddy -c "Add :persistent-apps array" ~/Library/Preferences/com.apple.dock.plist

# Add new items to the dock
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Slack.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'
defaults write com.apple.dock persistent-apps -array-add '<dict><key>tile-data</key><dict><key>file-data</key><dict><key>_CFURLString</key><string>/Applications/Google Chrome.app</string><key>_CFURLStringType</key><integer>0</integer></dict></dict></dict>'

# Restart Finder
fancy_echo "Restarting Finder..."
killall Dock
killall Finder && open /System/Library/CoreServices/Finder.app
fancy_echo "Rebuilding font cache..."
echo $passwd | sudo -S -k atsutil databases -remove

# Build locate database
fancy_echo "Building locate database..."
echo $passwd | sudo -S -k launchctl load -w /System/Library/LaunchDaemons/com.apple.locate.plist
echo $passwd | sudo -S -k /usr/libexec/locate.updatedb
echo "Finished building locate database"

