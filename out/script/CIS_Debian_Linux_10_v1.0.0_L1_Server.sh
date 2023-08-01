#!/bin/bash

echo '==|==' 
/sbin/modprobe -n -v freevxfs | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/usr/sbin/lsmod | /bin/grep freevxfs | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/modprobe -n -v jffs2 | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/sbin/lsmod | /bin/grep jffs2 | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/modprobe -n -v hfs | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/sbin/lsmod | /bin/grep hfs | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/modprobe -n -v hfsplus  | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/sbin/lsmod | /bin/grep hfsplus | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/sbin/lsmod | /bin/grep squashfs | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/sbin/lsmod | /bin/grep udf | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/systemctl is-enabled tmp.mount
echo '==|==' 
/bin/mount | /bin/grep /tmp
echo '==|==' 
/bin/mount | /bin/grep /tmp
echo '==|==' 
/bin/mount | /bin/grep /tmp
echo '==|==' 
/bin/mount | /bin/grep /tmp
echo '==|==' 
/bin/mount | /bin/grep /var/tmp
echo '==|==' 
/bin/mount | /bin/grep /var/tmp
echo '==|==' 
/bin/mount | /bin/grep /var/tmp
echo '==|==' 
/bin/mount | /bin/grep /home
echo '==|==' 
/bin/mount | /bin/grep /dev/shm
echo '==|==' 
/bin/mount | /bin/grep /dev/shm
echo '==|==' 
/bin/mount | /bin/grep /dev/shm
echo '==|==' 
/bin/mount | /bin/grep -P 'on[\s]+/dev/(floppy|cdrom|corder|mmcblk)'
echo '==|==' 
/bin/mount | /bin/grep -P 'on[\s]+/dev/(floppy|cdrom|corder|mmcblk)'
echo '==|==' 
/bin/mount | /bin/grep -P 'on[\s]+/dev/(floppy|cdrom|corder|mmcblk)'
echo '==|==' 
/bin/df --local -P | /usr/bin/awk {'if (NR!=1) print $6'} | /usr/bin/xargs -I '{}' /usr/bin/find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | /usr/bin/awk '{print} END {if (NR == 0) print "none"}'
echo '==|==' 
/bin/systemctl is-enabled autofs | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==|==' 
/sbin/modprobe -n -v usb-storage | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==|==' 
/usr/sbin/lsmod | /bin/grep usb-storage | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/apt-cache policy
echo '==|==' 
/usr/bin/apt-key list
echo '==|==' 
/usr/bin/dpkg -s sudo sudo-ldap 2>&1
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*Defaults[[:space:]]+(\[^#]+,[[:space:]]*)?use_pty' /etc/sudoers /etc/sudoers.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*Defaults[[:space:]]+(\[^#]+,[[:space:]]*)?logfile=' /etc/sudoers /etc/sudoers.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/dpkg -s aide 2>&1
echo '==|==' 
/usr/bin/crontab -u root -l | /bin/grep aide
echo '==|==' 
/bin/grep -r aide /etc/cron.* /etc/crontab
echo '==|==' 
/bin/systemctl is-enabled aidecheck.service
echo '==|==' 
/bin/systemctl is-enabled aidecheck.timer
echo '==|==' 
/bin/systemctl status aidecheck.timer
echo '==|==' 
/bin/journalctl | /bin/grep 'NX (Execute' 2>&1
echo '==|==' 
/bin/echo -n "$(grep noexec[0-9]*=off /proc/cmdline; grep -E -i ' (pae|nx) ' /proc/cpuinfo; grep '\sNX\s.*\sprotection:\s' /var/log/dmesg | /bin/grep -v active)" | /usr/bin/awk '{print} END {if (NR != 0) print "NX Protection is not active" ; else print "NX Protection is not supported"}'
echo '==|==' 
/sbin/sysctl kernel.randomize_va_space
echo '==|==' 
/bin/grep -s -P '^[\s]*kernel\.randomize_va_space[\s]*=[\s]*2[\s]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/dpkg -s prelink 2>&1
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*\*[[:space:]]+hard[[:space:]]+core[[:space:]]+0[[:space:]]*$' /etc/security/limits.conf /etc/security/limits.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl fs.suid_dumpable
echo '==|==' 
/usr/bin/grep -s -E '^[[:space:]]*fs\.suid_dumpable[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/dpkg -s apparmor | /bin/grep Status: 2>&1
echo '==|==' 
/usr/sbin/apparmor_status
echo '==|==' 
/usr/sbin/apparmor_status
echo '==|==' 
/usr/bin/apt-get -s upgrade
echo '==|==' 
/usr/bin/dpkg -s xinetd 2>&1
echo '==|==' 
/usr/bin/dpkg -s openbsd-inetd 2>&1
echo '==|==' 
/bin/systemctl is-enabled systemd-timesyncd.service
echo '==|==' 
grep -e 'NTP=' /etc/systemd/timesyncd.conf
echo '==|==' 
grep -e 'FallbackNTP=' /etc/systemd/timesyncd.conf
echo '==|==' 
/usr/bin/ps -ef | /usr/bin/grep chronyd | /usr/bin/grep -v grep | /usr/bin/cut -d ' ' -f 1
echo '==|==' 
/usr/bin/dpkg -l xserver-xorg*
echo '==|==' 
/bin/systemctl is-enabled avahi-daemon | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled cups | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled isc-dhcp-server | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled isc-dhcp-server6 | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled slapd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled nfs-server | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled rpcbind | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled bind9 | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled vsftpd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled apache2 | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled dovecot | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled smbd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled squid | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/bin/systemctl is-enabled snmpd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==|==' 
/usr/sbin/ss -lntu 2>&1 | /usr/bin/grep -E ':25\s' | /usr/bin/grep -E -v '\s(127.0.0.1|::1):25\s'
echo '==|==' 
/usr/bin/dpkg -s rsync | /bin/grep -E '(Status:|not installed)'
echo '==|==' 
/usr/bin/dpkg -s nis | /bin/grep -E '(Status:|not installed)'
echo '==|==' 
/usr/bin/dpkg -s nis 2>&1
echo '==|==' 
/usr/bin/dpkg -s rsh-client 2>&1
echo '==|==' 
/usr/bin/dpkg -s talk 2>&1
echo '==|==' 
/usr/bin/dpkg -s telnet 2>&1
echo '==|==' 
/usr/bin/dpkg -s ldap-utils 2>&1
echo '==|==' 
/usr/bin/nmcli radio wifi
echo '==|==' 
/sbin/sysctl net.ipv4.conf.default.send_redirects
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.send_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.conf.all.send_redirects
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.send_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.ip_forward
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.ip_forward[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv6.conf.all.forwarding
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.forwarding[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.conf.all.accept_source_route
echo '==|==' 
/sbin/sysctl net.ipv4.conf.default.accept_source_route
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv6.conf.all.accept_source_route
echo '==|==' 
/sbin/sysctl net.ipv6.conf.default.accept_source_route
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.default\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.conf.all.accept_redirects
echo '==|==' 
/sbin/sysctl net.ipv4.conf.default.accept_redirects
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv6.conf.default.accept_redirects
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.default\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.conf.all.secure_redirects
echo '==|==' 
/sbin/sysctl net.ipv4.conf.default.secure_redirects
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.secure_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.secure_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.conf.all.log_martians
echo '==|==' 
/sbin/sysctl net.ipv4.conf.default.log_martians
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.log_martians[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.log_martians[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.icmp_echo_ignore_broadcasts
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.icmp_echo_ignore_broadcasts[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.icmp_ignore_bogus_error_responses
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.icmp_ignore_bogus_error_responses[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.conf.all.rp_filter
echo '==|==' 
/sbin/sysctl net.ipv4.conf.default.rp_filter
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.rp_filter[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.rp_filter[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv4.tcp_syncookies
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.tcp_syncookies[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/sbin/sysctl net.ipv6.conf.all.accept_ra
echo '==|==' 
/sbin/sysctl net.ipv6.conf.default.accept_ra
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.accept_ra[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.default\.accept_ra[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/systemctl is-enabled ufw
echo '==|==' 
/usr/sbin/ufw status
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status verbose
echo '==|==' 
/usr/sbin/ufw status numbered
echo '==|==' 
/bin/ss -4tuln; /usr/sbin/ufw status
echo '==|==' 
/usr/sbin/iptables -L
echo '==|==' 
/usr/sbin/iptables -L
echo '==|==' 
/usr/sbin/nft list tables
echo '==|==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook input'
echo '==|==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook forward'
echo '==|==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook output'
echo '==|==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook input/,/}/' | /bin/grep 'iif "lo" accept'
echo '==|==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook input/,/}/' | /bin/grep 'ip saddr'
echo '==|==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook input/,/}/' | /bin/grep 'ip6 saddr'
echo '==|==' 
/usr/sbin/nft list ruleset
echo '==|==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook input'
echo '==|==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook forward'
echo '==|==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook output'
echo '==|==' 
/bin/systemctl is-enabled nftables
echo '==|==' 
/usr/bin/cat /etc/nftables.conf
echo '==|==' 
/sbin/ip6tables --list | /bin/grep 'Chain INPUT'
echo '==|==' 
/sbin/ip6tables --list | /bin/grep 'Chain FORWARD'
echo '==|==' 
/sbin/ip6tables --list | /bin/grep 'Chain OUTPUT'
echo '==|==' 
/usr/sbin/ip6tables -L INPUT -v -n | /usr/bin/awk '{ a[$3":"$4":"$5":"$6":"$7":"$8] = NR; print } END { if (a["ACCEPT:all:lo:*:::/0:::/0"] > 0 && a["ACCEPT:all:lo:*:::/0:::/0"] &lt; a["DROP:all:*:*:::1:::/0"]) { print "pass" } else { print "fail" } }'
echo '==|==' 
/usr/sbin/ip6tables -L OUTPUT -v -n | /usr/bin/awk '{ a[$3":"$4":"$5":"$6":"$7":"$8] = NR; print } END { if (a["ACCEPT:all:*:lo:::/0:::/0"] > 0) { print "pass" } else { print "fail" } }'
echo '==|==' 
/sbin/ip6tables -L -v -n
echo '==|==' 
/usr/bin/ss -ln; /sbin/ip6tables -L INPUT -v -n
echo '==|==' 
/usr/bin/dpkg -s rsyslog 2>&1
echo '==|==' 
/bin/systemctl is-enabled rsyslog | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==|==' 
/bin/grep '^\s*\*\.emerg' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo '==|==' 
/bin/egrep '^[\s]\*\$FileCreateMode' /etc/rsyslog.conf /etc/rsyslog.d/* | /usr/bin/awk '{ print; if(/\$FileCreateMode 0[246][04]0/) { print "pass" } else { print "fail"; fail=1; } } END { if(fail==1){ result="Failures found"; }; if(fail==0 && NR>0){ result="All results passing"; }; if(NR==0){ result="No results found"; }; print result; }'
echo '==|==' 
/bin/grep '\$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo '==|==' 
/bin/grep '\$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo '==|==' 
OUTPUT=$(ls -l /var/log); /usr/bin/find /var/log -type f -perm /g+wx,o+rwx -ls | /bin/awk -v awkvar="${OUTPUT}" '{print} END {if (NR == 0) print awkvar "\npass" ; else print "fail"}'
echo '==|==' 
/bin/systemctl is-enabled cron | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==|==' 
/usr/sbin/sshd -T | /bin/grep ciphers | /bin/grep -oP '((3des-cbc|aes128-cbc|aes192-cbc|aes256-cbc|arcfour|arcfour128|arcfour256|blowfish-cbc|cast128-cbcz|rijndael-cbc@lysator.liu.se)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==|==' 
/usr/sbin/sshd -T | /bin/grep -i 'MACs' | /bin/grep -oP '((hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1|hmac-sha1-96|hmac-sha1-96|umac-64@openssh.com|umac-128@openssh.com|hmac-md5-etm@openssh.com|hmac-md5-96-etm@openssh.com|hmac-ripemd160-etm@openssh.com|hmac-sha1-etm@openssh.com|hmac-sha1-96-etm@openssh.com|umac-64-etm@openssh.com|umac-128-etm@openssh.com)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==|==' 
/usr/sbin/sshd -T | /bin/grep -i 'kexalgorithms' | /bin/grep -oP '((diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==|==' 
/usr/sbin/sshd -T | /bin/grep clientaliveinterval
echo '==|==' 
/usr/sbin/sshd -T | /bin/grep clientalivecountmax
echo '==|==' 
/usr/sbin/sshd -T | /bin/grep logingracetime
echo '==|==' 
/usr/bin/grep -E '^[[:space:]]*minclass' /etc/security/pwquality.conf | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/grep -E '^[[:space:]]*minclass[[:space:]]*=[[:space:]]*4' /etc/security/pwquality.conf | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/bin/grep -P '^[[:space:]]*\Scredit[[:space:]]*=[[:space:]]*-[1-9]' /etc/security/pwquality.conf | /usr/bin/sed ':a;$!{N;s/\n/ /;ba;}' | /usr/bin/grep -P '(?=.*?dcredit).*(?=.*?ucredit).*(?=.*?ocredit).*(?=.*?lcredit)' | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -P '^[\s]*auth[\s]+required[\s]+pam_tally2\.so[\s]*' /etc/pam.d/common-auth | /bin/grep -P '(?=.*?onerr=fail).*(?=.*?audit).*(?=.*?silent).*(?=.*?deny=@PAM_DENY_VALUE@).*(?=.*?unlock_time=@PAM_LOCKOUT_VALUE@)' | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==|==' 
/usr/sbin/useradd -D | /bin/grep INACTIVE
echo '==|==' 
for user in $(cat /etc/shadow | cut -d: -f1); do expiry=$(date -d "$(chage --list $user | grep -Poi 'Last password change\s*\:[\s]*\K((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[\s]+[0-9]{1,2}, 2[0-9]{3})$')" +%s); today=$(date +%s); if [ $expiry -gt $today ]; then echo "$user expiry date is in future"; fi ; done | /usr/bin/awk '{print} END {if (NR == 0) print "pass"; else print "fail"}'
echo '==|==' 
/usr/bin/awk -F: '($1!="root" && $1!~\/^\+\/ && $3&lt;'"$(/usr/bin/awk '\/^[\s]*UID_MIN\/{print $2}' /etc/login\.defs)"') {print $1}' /etc/passwd | /usr/bin/xargs -I '{}' /usr/bin/passwd -S '{}' | /usr/bin/awk '($2!="L" && $2!="LK") {print $1}' | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==|==' 
/bin/grep -v "console" /etc/securetty | /usr/bin/awk '{ print } END { if (NR==0) print "none" }'
echo '==|==' 
/bin/grep pam_wheel.so /etc/pam.d/su; /bin/cat /etc/group
echo '==|==' 
/bin/cat /etc/shadow | /usr/bin/awk -F : '($2 == "") { print $1 " does not have a password."}'| /usr/bin/awk '{print} END {if (NR == 0) print "none"'}
echo '==|==' 
/bin/cat /etc/passwd | /bin/egrep -v '^(root|halt|sync|shutdown)' | /usr/bin/awk -F: '($7 != "/usr/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then /bin/echo "The home directory ($dir) of user $user does not exist."; fi; done | /usr/bin/awk '{ print } END { if(NR==0) { print "No results found" } }'
echo '==|==' 
for dir in $(/usr/bin/cat /etc/passwd | /usr/bin/egrep -v '(root|halt|sync|shutdown)' | /usr/bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'); do if [ -f "$dir/.netrc" ]; then fileperm=$(ls -ld $dir/.netrc | cut -f1 -d" "); if [ $(/usr/bin/echo $fileperm | cut -c5) != "-" ]; then /usr/bin/echo "Group Read set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c6) != "-" ]; then /usr/bin/echo "Group Write set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c7) != "-" ]; then /usr/bin/echo "Group Execute set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c8) != "-" ]; then /usr/bin/echo "Other Read set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c9) != "-" ]; then /usr/bin/echo "Other Write set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c10) != "-" ]; then /usr/bin/echo "Other Execute set on $dir/.netrc"; fi; fi; done | /usr/bin/awk '{ print } END { if (NR==0) print "All .netrc files are not group or world accessible" }'
echo '==|==' 
/usr/bin/cat /etc/passwd | /usr/bin/egrep -v '^(root|halt|sync|shutdown)' | /usr/bin/awk -F: '($7 != "/sbin/nologin") { print $1 " " $3 " " $6 }' | while read user uid dir; do if [ -f "$dir/.rhosts" ]; then /usr/bin/echo ".rhosts file $dir/.rhosts exists"; fi; done | /usr/bin/awk '{ print } END { if (NR==0) print "No .rhosts files found" }'
echo '==|==' 
/usr/bin/awk -F: 'FILENAME == "/etc/group" && $1 == "shadow" { gid=$3; if ($4!="") { print "secondary "$4; f=1 } } FILENAME == "/etc/passwd" && $4 == gid { print "primary "$1; f=1 } END { if (!f) print "shadow group empty" }' /etc/group /etc/passwd;