set -o errexit
set -o pipefail
set -o nounset
set -x

# create user
if [ ! $(id -u sean) ]
then
    adduser sean
    usermod -aG sudo sean
fi

# install tools
apt-get update
apt-get install -y neovim tmux nethack-console git sudo curl astyle ruby-beautify apache2-utils htop ranger pulseaudio fbset 

# install X 
sed -i -e 's/stretch/buster/g' /etc/apt/sources.list
apt-get update
apt-get install -y xinit i3 dmenu qutebrowser

curl -sL https://deb.nodesource.com/setup_9.x | sudo -E bash -
sudo apt-get install -y nodejs

curl -sL https://get.docker.com | bash
usermod -aG docker sean

npm install -g js-beautify prettier prettydiff nodemon

# symlink tools

if [ -f /usr/bin/nvim ]
then
    rm /usr/bin/vim
    ln -s /usr/bin/nvim /usr/bin/vim
fi

# clone frequently used repos
if [ ! -d /home/sean/OneRepoToRuleThemAll ] 
then
    su sean -c 'cd ~ && git clone https://github.com/chickenninja/OneRepoToRuleThemAll.git'
fi
if [ ! -d /home/sean/dotfiles ] 
then
    su sean -c 'cd ~ && git clone https://github.com/chickenninja/dotfiles.git'
fi

# config stuff
su sean -c 'cd ~ && git config --global user.email "sean@example.com"'
su sean -c 'cd ~ && git config --global user.name "Sean Davis"'

if [ ! -d /home/sean/.local/share/nvim/site/pack/git-plugins/start ] 
then
    su sean -c 'cd ~ && mkdir -p ~/.local/share/nvim/site/pack/git-plugins/start && git clone https://github.com/w0rp/ale.git ~/.local/share/nvim/site/pack/git-plugins/start/ale && git clone https://github.com/sbdchd/neoformat.git ~/.local/share/nvim/site/pack/git-plugins/start/neoformat'
fi

echo 'export EDITOR="/usr/bin/nvim"' >> /home/sean/.bashrc

# setup dotfiles
su sean -c '/home/sean/dotfiles/link.sh'

# fix ssh
if [ ! -f /home/sean/.ssh/authorized_keys ]
then
    echo "Public key not found for ssh..."
    su sean -c "mkdir -p /home/sean/.ssh"
    echo "Please copy key into .ssh directory"
    exit 1
fi

chown sean /home/sean/.ssh/authorized_keys
su sean -c "chmod 700 /home/sean/.ssh"
su sean -c "chmod 600 /home/sean/.ssh/authorized_keys"
su sean -c "chown -R sean /home/sean/.ssh"

sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
sed -i 's/X11 Forwarding/X11 Forwarding/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

systemctl restart sshd

hostnamectl set-hostname HAL9000
echo "127.0.0.1    HAL9000" >> /etc/hosts
