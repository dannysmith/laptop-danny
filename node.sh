fancy_echo "Updating NVM and NPM..."

nvm install node
node --version

npm update npm -g
npm update -g

green_echo "done."

fancy_echo "Istalling global NPM packages..."

npm install -g gitbook-cli grunt-cli pryjs nodemon browser-sync phantomjs yo nightwatch

green_echo "done."

green_echo "Done with Node/NPM installs!"
