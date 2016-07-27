# Danny's Laptop Install Script

To configure and install a new laptop...

```shell
xcode-select --install # Install command line tools
sudo softwareupdate -iva # Run a software update

git clone http://github.com/dannysmith/laptop-danny ~/Desktop
cd ~/Desktop/laptop-danny
chmod +x ./mac
./mac
```

https://github.com/dghubble/phoenix

Manual Steps:

* Log into Dropbox and Evernote and begin sync
* Open Kaleidoscope Preferences and install the `ksdiff` command line tool
* Install [Craft for Sketch](https://www.invisionapp.com/craft)


TODO:

* Set up zsh & oh-my-zsh properly
* Configure as many apps as possible via command line
* Run dropbox sync
* Clone sparta workstation down
* Automaticually licence non MAS apps:
    * Sketch
    * Omnifocus
    * Bartender
    * Alfred
    * 1Password
    * iStat Menus
* Add checks for software already installed

**NOTE: KEEP ADDING TO THIS WHEN I INSTALL NEW SOFTWARE**
