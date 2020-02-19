#/bin/bash

# Installation script for Debian/Ubuntu
# Author: whois
# Twitter: @JuhoJauhiainen

cd /tmp

# Clone the repo
git clone https://github.com/keydet89/RegRipper2.8.git
cd RegRipper2.8/

# Tailoring the script for Linux
tail -n +2 rip.pl > rip
perl -pi -e 'tr[\r][]d' rip
sed -i "1i #\!$(which perl)" rip
sed -i 's/\#my\ \$plugindir/\my\ \$plugindir/g' rip
sed -i 's/\#push/push/' rip
sed -i 's/\"plugins\/\"\;/\"\/usr\/share\/regripper\/plugins\/\"\;/' rip
sed -i 's/(\"plugins\")\;/(\"\/usr\/share\/regripper\/plugins\")\;/' rip

# Using cpanminus to install Win32registry module, for some reason tests fail when building so Luke has to use force
sudo apt-get install cpanminus -y
sudo cpanm Parse::Win32Registry --force

# Make directory for plugins
sudo mkdir -p /usr/share/regripper/
sudo cp -r plugins/ /usr/share/regripper/

# Move the ripper to path
sudo mv rip /usr/local/bin/rip.pl
chmod +x /usr/local/bin/rip.pl
source ~/.bashrc

# Get rid the rest files
cd
rm -rf /tmp/RegRipper2.8

