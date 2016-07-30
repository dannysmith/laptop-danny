# Find App ID numbers with `mas search "appname"`.

fancy_echo "Installing Mac App Store Apps.."
mas signout
mas signin $email "$apple_passwd"

mas install 992076693 # Mndnote 2
mas install 974971992 # Alternote
mas install 824183456 # Affinity Photo
mas install 880001334 # Reeder 3
mas install 558268579 # MailRaider
mas install 587512244 # Kaleidoscope
mas install 775737590 # iA Writer
mas install 455970963 # Disk doctor
mas install 403388562 # Transmit
mas install 406825478 # Telephone
mas install 409789998 # Twitter

echo "Outdated Mac App Store Apps:"
mas outdated

fancy_echo "Upgrading Mac App store Apps.."
mas upgrade

green_echo "Done with Mac App Store installs..."
