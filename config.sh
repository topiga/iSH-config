#!/bin/bash
cd ~
wget http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86/apk-tools-static-2.10.5-r1.apk
tar xf apk-tools-static-2.10.5-r1.apk sbin/apk.static
./sbin/apk.static add apk-tools
rm -r sbin
apk update && apk upgrade
apk add bash openssl openssh sudo nano mandoc
apk add man-pages 
apk add less less-doc
addgroup sudo
echo "user
user
" | adduser user
adduser user sudo
echo "alpine
alpine
" | passwd root
echo "%sudo   ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
sed -i 's/\/bin\/ash/\/bin\/bash/g' /etc/passwd
sleep 1
cat << EOF > /root/.bash_profile
export PS1="\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
alias update='apk update && apk upgrade'
export HISTTIMEFORMAT="%d/%m/%y %T "
alias ls='ls --color=auto'
EOF
cat << EOF > /home/user/.bash_profile
export PS1="\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
alias update='apk update && apk upgrade'
export HISTTIMEFORMAT="%d/%m/%y %T "
alias ls='ls --color=auto'
EOF
reboot
