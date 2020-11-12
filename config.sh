#!/bin/bash
cd ~
wget http://dl-cdn.alpinelinux.org/alpine/v3.12/main/x86/apk-tools-static-2.10.5-r1.apk
tar xf apk-tools-static-2.10.5-r1.apk sbin/apk.static
./sbin/apk.static add apk-tools
rm -r sbin
apk add bash openssl openssh sudo nano mandoc man-pages less less-doc
cat /etc/passwd | tail -n $(($(cat /etc/passwd | wc -l)-1)) > tmp_passwd && echo 'root:x:0:0:root:/root:/bin/bash' > /etc/passwd && cat tmp_passwd >> /etc/passwd && rm -f tmp_passwd
sleep 1
cat << EOF > ~/.bash_profile
export PS1="\[\033[01;31m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]\$ "
alias update='apk update && apk upgrade'
export HISTTIMEFORMAT="%d/%m/%y %T "
alias ls='ls --color=auto'
EOF
addgroup sudo
echo "alpine
alpine
" | adduser user
adduser user sudo
echo "admin
admin
" | adduser admin
addgroup admin
addgroup admin admin
echo "%sudo   ALL=(ALL:ALL) ALL
%admin     ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
reboot

