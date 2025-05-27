# Foreman install ( puppetserver, puppet-agent) and pdk 

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
``

## containers





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
