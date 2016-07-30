fancy_echo "Updating NVM and NPM..."

nvm install latest
nvm -v

npm update npm -g
npm update -g

fancy_echo "Istalling global NPM packages..."

npm install -g gitbook-cli grunt-cli pryjs

green_echo "Done with Node/NPM installs!"
