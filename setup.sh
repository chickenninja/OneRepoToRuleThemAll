
set -o errexit
set -o pipefail
set -o nounset


# create user
if [ ! $(id -u sean) ]
then
    adduser sean
    usermod -aG sudo sean
fi

# install tools
apt-get update
apt-get install -y neovim tmux nethack-console git nodejs sudo

# clone frequently used repos
su sean -c 'git clone https://github.com/chickenninja/OneRepoToRuleThemAll.git /home/sean'

# config stuff
su sean -c 'git config --global user.email "sean@example.com"'
su sean -c 'git config --global user.name "Sean Davis"'

# setup dotfiles

# fix ssh
if [ ! -f /home/sean/.ssh/authorized_keys ]
then
    echo "Public key not found for ssh..."
    su sean -c "mkdir -p /home/sean/.ssh"
    echo "Please copy key into .ssh directory"
    exit 1
fi

su sean -c "chmod 700 /home/sean/.ssh"
su sean -c "chmod 600 /home/sean/.ssh/authorized_keys"
su sean -c "chown -R sean /home/sean/.ssh"

sed -i 's/PasswordAuthentication yes/PasswordAuthentication no/g' /etc/ssh/sshd_config
sed -i 's/UsePAM yes/UsePAM no/g' /etc/ssh/sshd_config
sed -i 's/X11 Forwarding/X11 Forwarding/g' /etc/ssh/sshd_config
sed -i 's/#PubkeyAuthentication/PubkeyAuthentication/g' /etc/ssh/sshd_config
sed -i 's/PermitRootLogin yes/PermitRootLogin no/g' /etc/ssh/sshd_config

systemctl restart sshd
