# Install additional libraries required for Python 3.5.
sudo apt-get install -y build-essential \
                        libncurses5-dev \
                        libreadline6-dev \
                        libssl-dev \
                        zlib1g-dev

# Download Python 3.5.
if [ -z ~/Downloads/Python-3.5.3.tgz ]; then
  mkdir -p ~/Downloads
  cd ~/Downloads
  wget https://www.python.org/ftp/python/3.5.3/Python-3.5.3.tgz
  tar -xvzf Python-3.5.3.tgz
fi

# Finally, install Python 3.5.
cd ~/Downloads/Python-3.5.3
./configure --enable-optimizations
make
sudo make install
