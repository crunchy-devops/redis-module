# r10k install
```shell
dnf install ruby ruby-devel gem -y
dnf groupinstall "Development Tools" -y
gem install r10k
dnf groupinfo
cp /usr/local/share/gems/gems/r10k-4.1.0/bin/r10k /usr/bin/
r10k --help
```