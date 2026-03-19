# Upgrade your Debian system
apt-upgrade:
    sudo apt update && sudo apt upgrade -y

# Clean up OS packages
apt-clean:
    sudo apt autoremove && sudo apt autoclean
