## install docker and puppetmaster on alma-linux 9
```shell
sudo -s
dnf update -y
dnf install epel-release -y
dnf install htop  git -y
#vi /etc/sysconfig/selinux
#setenforce 0
dnf install https://yum.puppet.com/puppet8-release-el-9.noarch.rpm
dnf install puppetserver
#vim /etc/sysconfig/puppetserver
#hostnamectl set-hostname puppetmaster.example.com
vim /etc/hosts
hostnamectl
vim /etc/puppetlabs/puppet/puppet.conf
systemctl start puppetserver
systemctl enable puppetserver
systemctl status puppetserver
puppetserver -v
# install docker
dnf update -y
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install docker-ce docker-ce-cli containerd.io -y
systemctl start docker
systemctl enable docker
# choose your username
usermod -aG docker $USER


## Foreman install ( puppetserver, puppet-agent) and pdk 

```shell
dnf update -y
sudo hostnamectl set-hostname puppet.example.com
vi /etc/hosts
ping -c 2 $( hostname -f )
systemctl enable --now chronyd
chronyc sources
timedatectl
dnf -y install https://yum.puppet.com/puppet8-release-el-9.noarch.rpm
dnf -y install https://yum.theforeman.org/releases/latest/el9/x86_64/foreman-release.rpm
dnf install foreman-installer -y
foreman-installer -i
vi /etc/resolv.conf
foreman-installer -i
vi /etc/resolv.conf
vi /etc/hosts
foreman-installer -i
vi /etc/hosts
hostnamectl set-hostname noble-foreman.c.webforce3-378713.internal
foreman-installer -i
df -h
foreman-rake permissions:reset
dnf install puppetserver  -y
find / -name puppetserver -print 2>/dev/null
/opt/puppetlabs/bin/puppetserver --version
/opt/puppetlabs/bin/puppet agent --version
dnf update -y
dnf config-manager --add-repo=https://download.docker.com/linux/centos/docker-ce.repo
dnf install -y docker-ce docker-ce-cli containerd.io
systemctl start docker
systemctl enable docker
dnf -y install  https://yum.puppet.com/puppet-tools-release-el-9.noarch.rpm
dnf -y install pdk
```

## Portainer Container
```shell
docker volume create portainer_data
docker run -d -p 32125:8000 -p 32126:9443 --name portainer --restart=always \
-v /var/run/docker.sock:/var/run/docker.sock \
-v portainer_data:/data portainer/portainer-ce:latest
```
log on immediately to https://<vm_ip>:32126 and create an account/password 
otherwise portainer container will be timeouted.

## Build sandbox containers 
```shell
git clone https://github.com/crunchy-devops/noble-puppet.git
cd noble-puppet
cd alma
docker build -t alma-puppet:latest .
cd ../alpine    
docker build -t alpine-puppet:latest .
cd ../ubuntu
docker build -t ubuntu-puppet:latest .
cd ../
docker images
```
## Start containers
```bash
# add-host is this internal DNS entry for the puppet server
docker run --name target1 -d -p 2222:22 --add-host=puppet:10.200.15.214 --hostname=alma.com alma-puppet
docker run --name target2 -d -p 2223:22 --add-host=puppet:10.200.15.214 --hostname=alpine.com alpine-puppet
docker run --name target3 -d -p 2224:22 --add-host=puppet:10.200.15.214 --hostname=ubuntu.com ubuntu-puppet
```

## Troubleshooting
```shell
# on a client puppet agent
puppet agent -tv
# on the server
puppetserver ca list -a
# if an error occurs, on the server
puppetserver ca clean --certname <CERTNAME_OF_YOUR_SERVER>
# on the puppet agent host 
find / -name ssl -print 2>/dev/null
rm -rf /etc/puppetlabs/puppet/ssl
puppet agent -tv
#  on the server
puppetserver ca sign --certname <CERTNAME_OF_YOUR_SERVER>
puppetserver ca list -a
```

## adding .gitkeep in the directory module
```shell
cd redis/
find . -type d -empty -not -path "./.git/*" -exec touch {}/.gitkeep \;
```
