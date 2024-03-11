# system
apt-get update
apt-get upgrade -y
apt-get install  # ppas and vim nox fixes 'char problems'

# rails/ruby + packages
apt-get install \
             vim vim-nox software-properties-common \
             g++ gcc make libc6-dev patch openssl ca-certificates libreadline6 libreadline6-dev \
             curl zlib1g zlib1g-dev libssl-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev \
             libxslt1-dev autoconf libc6-dev libgdbm-dev libncurses5-dev automake libtool bison pkg-config libffi-dev \
             libcurl4-openssl-dev git \
             libmagickwand-dev imagemagick

# NGINX only?
sudo apt-get install nginx             


# Add mblz user to sudo
adduser mblz
  # sudo privs / add user to admin group for sudo
groupadd admin
usermod -g admin mblz
  # secure system
  # http://blog.cirronix.com/2011/06/ubuntu-server-simple-four-stage.html
# not root login
vim /etc/ssh/sshd_config
PermitRootLogin no
service ssh restart

aptitude -y install denyhosts
aptitude -y install ufw
ufw allow ssh
ufw allow http
ufw enable

# keys
ssh-keygen -t rsa
  # add pub key to github then check it
ssh -T git@github.com



# git
git config --global user.name "Elva Tristan"
git config --global user.email admin@mblz.com
git config --global color.diff auto
git config --global color.status auto
git config --global color.branch auto
git config --global color.status.changed yellow
git config --global color.status.added green
git config --global color.status.untracked red
git config --list

# mysql
apt-get install mysql-server mysql-client libmysqlclient-dev

#rbenv
git clone git://github.com/sstephenson/rbenv.git ~/.rbenv
echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc
echo 'eval "$(rbenv init -)"' >> ~/.bashrc
exec $SHELL

mkdir ~/.rbenv/plugins
git clone git://github.com/sstephenson/ruby-build.git ~/.rbenv/plugins/ruby-build
exec $SHELL

# ruby
rbenv install  1.8.7-p371
rbenv install 2.0.0-rc2

# gems
echo "install: --no-ri --no-rdoc" >> ~/.gemrc
echo "update: --no-ri --no-rdoc" >> ~/.gemrc
gem install bunlder
gem install rails
gem install passenger

# bundle from

# nginx
/home/mblz/.rbenv/shims/passenger-install-nginx-module
  # Site configs cat ../sites/configs
mkdir /opt/nginx/conf/sites



# rails
#bundle install on cap deploy 

# Files
# PVR from ./system
rsync -avz avatars mblz@198.199.103.142:~/assets/pvr/system/
# CMS from ./cms
rsync -avz uploads/ mblz@198.199.103.142:~/assets/cms/uploads/


