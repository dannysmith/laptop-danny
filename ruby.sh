gem_install_or_update() {
  if gem list "$1" --installed > /dev/null; then
    gem update "$@"
  else
    gem install "$@"
    rbenv rehash
  fi
}

# Install Ruby
find_latest_ruby() {
  rbenv install -l | grep -v - | tail -1 | sed -e 's/^ *//'
}

ruby_version="$(find_latest_ruby)"

fancy_echo "Installing and Configuring rbenv and ruby..."

# append_to_zshrc 'eval "$(rbenv init - --no-rehash)"' 1
eval "$(rbenv init -)"

# Set Default rubygems to include in all ruby installations via rbenv
fancy_echo "Setting default gems..."

cat > "$HOME/.rbenv/default-gems" <<-EOF
bundler
brice
gist
pry
pry-doc
awesome_print
specific_install
EOF

if ! rbenv versions | grep -Fq "$ruby_version"; then
  fancy_echo "Installing ruby $ruby_version..."
  RUBY_CONFIGURE_OPTS=--with-openssl-dir=/usr/local/opt/openssl rbenv install -s "$ruby_version"
fi

rbenv global "$ruby_version"
gem update --system
gem_install_or_update 'bundler'
gem_install_or_update 'brice'
gem_install_or_update 'pry'
gem_install_or_update 'pry-doc'
gem_install_or_update 'awesome_print'
number_of_cores=$(sysctl -n hw.ncpu)
bundle config --global jobs $((number_of_cores - 1))
