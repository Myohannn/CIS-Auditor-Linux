#!/bin/bash

echo '==0==' 
/sbin/modprobe -n -v freevxfs | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==1==' 
/usr/sbin/lsmod | /bin/grep freevxfs | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==2==' 
/sbin/modprobe -n -v jffs2 | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==3==' 
/sbin/lsmod | /bin/grep jffs2 | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==4==' 
/sbin/modprobe -n -v hfs | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==5==' 
/sbin/lsmod | /bin/grep hfs | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==6==' 
/sbin/modprobe -n -v hfsplus  | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==7==' 
/sbin/lsmod | /bin/grep hfsplus | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==8==' 
/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==9==' 
/sbin/lsmod | /bin/grep squashfs | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==10==' 
/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==11==' 
/sbin/lsmod | /bin/grep udf | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==12==' 
/bin/systemctl is-enabled tmp.mount
echo '==13==' 
/bin/mount | /bin/grep /tmp
echo '==14==' 
/bin/mount | /bin/grep /tmp
echo '==15==' 
/bin/mount | /bin/grep /tmp
echo '==16==' 
/bin/mount | /bin/grep /tmp
echo '==17==' 
/bin/mount | /bin/grep /var/tmp
echo '==18==' 
/bin/mount | /bin/grep /var/tmp
echo '==19==' 
/bin/mount | /bin/grep /var/tmp
echo '==20==' 
/bin/mount | /bin/grep /home
echo '==21==' 
/bin/mount | /bin/grep /dev/shm
echo '==22==' 
/bin/mount | /bin/grep /dev/shm
echo '==23==' 
/bin/mount | /bin/grep /dev/shm
echo '==24==' 
/bin/mount | /bin/grep -P 'on[\s]+/dev/(floppy|cdrom|corder|mmcblk)'
echo '==25==' 
/bin/mount | /bin/grep -P 'on[\s]+/dev/(floppy|cdrom|corder|mmcblk)'
echo '==26==' 
/bin/mount | /bin/grep -P 'on[\s]+/dev/(floppy|cdrom|corder|mmcblk)'
echo '==27==' 
/bin/df --local -P | /usr/bin/awk {'if (NR!=1) print $6'} | /usr/bin/xargs -I '{}' /usr/bin/find '{}' -xdev -type d \( -perm -0002 -a ! -perm -1000 \) 2>/dev/null | /usr/bin/awk '{print} END {if (NR == 0) print "none"}'
echo '==28==' 
/bin/systemctl is-enabled autofs | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==29==' 
/sbin/modprobe -n -v usb-storage | /usr/bin/awk '{print} END {if (NR == 0) print "fail"}'
echo '==30==' 
/usr/sbin/lsmod | /bin/grep usb-storage | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==31==' 
/usr/bin/apt-cache policy
echo '==32==' 
/usr/bin/apt-key list
echo '==33==' 
/usr/bin/dpkg -s sudo sudo-ldap 2>&1
echo '==34==' 
/bin/grep -s -E '^[[:space:]]*Defaults[[:space:]]+(\[^#]+,[[:space:]]*)?use_pty' /etc/sudoers /etc/sudoers.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==35==' 
/bin/grep -s -E '^[[:space:]]*Defaults[[:space:]]+(\[^#]+,[[:space:]]*)?logfile=' /etc/sudoers /etc/sudoers.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==36==' 
/usr/bin/dpkg -s aide 2>&1
echo '==37==' 
/usr/bin/crontab -u root -l | /bin/grep aide
echo '==38==' 
/bin/grep -r aide /etc/cron.* /etc/crontab
echo '==39==' 
/bin/systemctl is-enabled aidecheck.service
echo '==40==' 
/bin/systemctl is-enabled aidecheck.timer
echo '==41==' 
/bin/systemctl status aidecheck.timer
echo '==42==' 
/bin/journalctl | /bin/grep 'NX (Execute' 2>&1
echo '==43==' 
/bin/echo -n "$(grep noexec[0-9]*=off /proc/cmdline; grep -E -i ' (pae|nx) ' /proc/cpuinfo; grep '\sNX\s.*\sprotection:\s' /var/log/dmesg | /bin/grep -v active)" | /usr/bin/awk '{print} END {if (NR != 0) print "NX Protection is not active" ; else print "NX Protection is not supported"}'
echo '==44==' 
/sbin/sysctl kernel.randomize_va_space
echo '==45==' 
/bin/grep -s -P '^[\s]*kernel\.randomize_va_space[\s]*=[\s]*2[\s]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==46==' 
/usr/bin/dpkg -s prelink 2>&1
echo '==47==' 
/bin/grep -s -E '^[[:space:]]*\*[[:space:]]+hard[[:space:]]+core[[:space:]]+0[[:space:]]*$' /etc/security/limits.conf /etc/security/limits.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==48==' 
/sbin/sysctl fs.suid_dumpable
echo '==49==' 
/usr/bin/grep -s -E '^[[:space:]]*fs\.suid_dumpable[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==50==' 
/usr/bin/dpkg -s systemd-coredump | /bin/grep Status: 2>&1
echo '==51==' 
/usr/bin/dpkg -s apparmor | /bin/grep Status: 2>&1
echo '==52==' 
/usr/sbin/apparmor_status
echo '==53==' 
/usr/sbin/apparmor_status
echo '==54==' 
/usr/bin/dpkg -s gdm3 2>&1
echo '==55==' 
/usr/bin/apt-get -s upgrade
echo '==56==' 
/usr/bin/dpkg -s xinetd 2>&1
echo '==57==' 
/usr/bin/dpkg -s openbsd-inetd 2>&1
echo '==58==' 
/usr/bin/dpkg -s ntp 2>&1
echo '==59==' 
/usr/bin/dpkg -s chrony 2>&1
echo '==60==' 
/bin/systemctl is-enabled systemd-timesyncd.service
echo '==61==' 
/bin/systemctl is-enabled systemd-timesyncd.service
echo '==62==' 
grep -e 'NTP=' /etc/systemd/timesyncd.conf
echo '==63==' 
grep -e 'FallbackNTP=' /etc/systemd/timesyncd.conf
echo '==64==' 
/usr/bin/dpkg -s chrony 2>&1
echo '==65==' 
/usr/bin/ps -ef | /usr/bin/grep chronyd | /usr/bin/grep -v grep | /usr/bin/cut -d ' ' -f 1
echo '==66==' 
/usr/bin/dpkg -s ntp 2>&1
echo '==67==' 
/usr/bin/dpkg -l xserver-xorg*
echo '==68==' 
/bin/systemctl is-enabled avahi-daemon | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==69==' 
/bin/systemctl is-enabled cups | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==70==' 
/bin/systemctl is-enabled isc-dhcp-server | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==71==' 
/bin/systemctl is-enabled isc-dhcp-server6 | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==72==' 
/bin/systemctl is-enabled slapd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==73==' 
/bin/systemctl is-enabled nfs-server | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==74==' 
/bin/systemctl is-enabled rpcbind | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==75==' 
/bin/systemctl is-enabled bind9 | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==76==' 
/bin/systemctl is-enabled vsftpd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==77==' 
/bin/systemctl is-enabled apache2 | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==78==' 
/bin/systemctl is-enabled dovecot | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==79==' 
/bin/systemctl is-enabled smbd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==80==' 
/bin/systemctl is-enabled squid | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==81==' 
/bin/systemctl is-enabled snmpd | /usr/bin/awk '{print} END { if(NR==0) print "disabled" }'
echo '==82==' 
/usr/bin/dpkg -s postfix 2>&1
echo '==83==' 
/usr/sbin/ss -lntu 2>&1 | /usr/bin/grep -E ':25\s' | /usr/bin/grep -E -v '\s(127.0.0.1|::1):25\s'
echo '==84==' 
/usr/bin/dpkg -s rsync | /bin/grep -E '(Status:|not installed)'
echo '==85==' 
/usr/bin/dpkg -s nis | /bin/grep -E '(Status:|not installed)'
echo '==86==' 
/usr/bin/dpkg -s nis 2>&1
echo '==87==' 
/usr/bin/dpkg -s rsh-client 2>&1
echo '==88==' 
/usr/bin/dpkg -s talk 2>&1
echo '==89==' 
/usr/bin/dpkg -s telnet 2>&1
echo '==90==' 
/usr/bin/dpkg -s ldap-utils 2>&1
echo '==91==' 
/usr/bin/nmcli radio wifi
echo '==92==' 
/sbin/sysctl net.ipv4.conf.default.send_redirects
echo '==93==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.send_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==94==' 
/sbin/sysctl net.ipv4.conf.all.send_redirects
echo '==95==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.send_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==96==' 
/sbin/sysctl net.ipv4.ip_forward
echo '==97==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.ip_forward[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==98==' 
/sbin/sysctl net.ipv6.conf.all.forwarding
echo '==99==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.forwarding[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==100==' 
/sbin/sysctl net.ipv4.conf.all.accept_source_route
echo '==101==' 
/sbin/sysctl net.ipv4.conf.default.accept_source_route
echo '==102==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==103==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==104==' 
/sbin/sysctl net.ipv6.conf.all.accept_source_route
echo '==105==' 
/sbin/sysctl net.ipv6.conf.default.accept_source_route
echo '==106==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==107==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.default\.accept_source_route[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==108==' 
/sbin/sysctl net.ipv4.conf.all.accept_redirects
echo '==109==' 
/sbin/sysctl net.ipv4.conf.default.accept_redirects
echo '==110==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==111==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==112==' 
/sbin/sysctl net.ipv6.conf.default.accept_redirects
echo '==113==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==114==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.default\.accept_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==115==' 
/sbin/sysctl net.ipv4.conf.all.secure_redirects
echo '==116==' 
/sbin/sysctl net.ipv4.conf.default.secure_redirects
echo '==117==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.secure_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==118==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.secure_redirects[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==119==' 
/sbin/sysctl net.ipv4.conf.all.log_martians
echo '==120==' 
/sbin/sysctl net.ipv4.conf.default.log_martians
echo '==121==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.log_martians[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==122==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.log_martians[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==123==' 
/sbin/sysctl net.ipv4.icmp_echo_ignore_broadcasts
echo '==124==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.icmp_echo_ignore_broadcasts[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==125==' 
/sbin/sysctl net.ipv4.icmp_ignore_bogus_error_responses
echo '==126==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.icmp_ignore_bogus_error_responses[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass"; else print "fail"}'
echo '==127==' 
/sbin/sysctl net.ipv4.conf.all.rp_filter
echo '==128==' 
/sbin/sysctl net.ipv4.conf.default.rp_filter
echo '==129==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.all\.rp_filter[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==130==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.conf\.default\.rp_filter[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==131==' 
/sbin/sysctl net.ipv4.tcp_syncookies
echo '==132==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv4\.tcp_syncookies[[:space:]]*=[[:space:]]*1[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==133==' 
/sbin/sysctl net.ipv6.conf.all.accept_ra
echo '==134==' 
/sbin/sysctl net.ipv6.conf.default.accept_ra
echo '==135==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.all\.accept_ra[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==136==' 
/bin/grep -s -E '^[[:space:]]*net\.ipv6\.conf\.default\.accept_ra[[:space:]]*=[[:space:]]*0[[:space:]]*$' /etc/sysctl.conf /etc/sysctl.d/* |/usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==137==' 
/usr/bin/dpkg -s ufw 2>&1
echo '==138==' 
/usr/bin/dpkg -s nftables 2>&1
echo '==139==' 
/usr/bin/dpkg -s iptables 2>&1
echo '==140==' 
/usr/bin/dpkg -s ufw 2>&1
echo '==141==' 
/usr/bin/systemctl is-enabled ufw
echo '==142==' 
/usr/sbin/ufw status
echo '==143==' 
/usr/sbin/ufw status verbose
echo '==144==' 
/usr/sbin/ufw status verbose
echo '==145==' 
/usr/sbin/ufw status verbose
echo '==146==' 
/usr/sbin/ufw status verbose
echo '==147==' 
/usr/sbin/ufw status verbose
echo '==148==' 
/usr/sbin/ufw status verbose
echo '==149==' 
/usr/sbin/ufw status verbose
echo '==150==' 
/usr/sbin/ufw status numbered
echo '==151==' 
/bin/ss -4tuln; /usr/sbin/ufw status
echo '==152==' 
/usr/bin/dpkg -s nftables 2>&1
echo '==153==' 
/usr/sbin/iptables -L
echo '==154==' 
/usr/sbin/iptables -L
echo '==155==' 
/usr/sbin/nft list tables
echo '==156==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook input'
echo '==157==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook forward'
echo '==158==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook output'
echo '==159==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook input/,/}/' | /bin/grep 'iif "lo" accept'
echo '==160==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook input/,/}/' | /bin/grep 'ip saddr'
echo '==161==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook input/,/}/' | /bin/grep 'ip6 saddr'
echo '==162==' 
/usr/sbin/nft list ruleset
echo '==163==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook input'
echo '==164==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook forward'
echo '==165==' 
/usr/sbin/nft list ruleset | /bin/grep 'hook output'
echo '==166==' 
/bin/systemctl is-enabled nftables
echo '==167==' 
/usr/bin/cat /etc/nftables.conf
echo '==168==' 
/sbin/ip6tables --list | /bin/grep 'Chain INPUT'
echo '==169==' 
/sbin/ip6tables --list | /bin/grep 'Chain FORWARD'
echo '==170==' 
/sbin/ip6tables --list | /bin/grep 'Chain OUTPUT'
echo '==171==' 
/usr/sbin/ip6tables -L INPUT -v -n | /usr/bin/awk '{ a[$3":"$4":"$5":"$6":"$7":"$8] = NR; print } END { if (a["ACCEPT:all:lo:*:::/0:::/0"] > 0 && a["ACCEPT:all:lo:*:::/0:::/0"] &lt; a["DROP:all:*:*:::1:::/0"]) { print "pass" } else { print "fail" } }'
echo '==172==' 
/usr/sbin/ip6tables -L OUTPUT -v -n | /usr/bin/awk '{ a[$3":"$4":"$5":"$6":"$7":"$8] = NR; print } END { if (a["ACCEPT:all:*:lo:::/0:::/0"] > 0) { print "pass" } else { print "fail" } }'
echo '==173==' 
/sbin/ip6tables -L -v -n
echo '==174==' 
/usr/bin/ss -ln; /sbin/ip6tables -L INPUT -v -n
echo '==175==' 
/usr/bin/dpkg -s rsyslog 2>&1
echo '==176==' 
/usr/bin/dpkg -s rsyslog 2>&1
echo '==177==' 
/bin/systemctl is-enabled rsyslog | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==178==' 
/bin/grep '^\s*\*\.emerg' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo '==179==' 
/bin/egrep '^[\s]\*\$FileCreateMode' /etc/rsyslog.conf /etc/rsyslog.d/* | /usr/bin/awk '{ print; if(/\$FileCreateMode 0[246][04]0/) { print "pass" } else { print "fail"; fail=1; } } END { if(fail==1){ result="Failures found"; }; if(fail==0 && NR>0){ result="All results passing"; }; if(NR==0){ result="No results found"; }; print result; }'
echo '==180==' 
/bin/grep '\$ModLoad imtcp' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo '==181==' 
/bin/grep '\$InputTCPServerRun' /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo '==182==' 
OUTPUT=$(ls -l /var/log); /usr/bin/find /var/log -type f -perm /g+wx,o+rwx -ls | /bin/awk -v awkvar="${OUTPUT}" '{print} END {if (NR == 0) print awkvar "\npass" ; else print "fail"}'
echo '==183==' 
/bin/systemctl is-enabled cron | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==184==' 
/usr/sbin/sshd -T | /bin/grep ciphers | /bin/grep -oP '((3des-cbc|aes128-cbc|aes192-cbc|aes256-cbc|arcfour|arcfour128|arcfour256|blowfish-cbc|cast128-cbcz|rijndael-cbc@lysator.liu.se)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==185==' 
/usr/sbin/sshd -T | /bin/grep -i 'MACs' | /bin/grep -oP '((hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1|hmac-sha1-96|hmac-sha1-96|umac-64@openssh.com|umac-128@openssh.com|hmac-md5-etm@openssh.com|hmac-md5-96-etm@openssh.com|hmac-ripemd160-etm@openssh.com|hmac-sha1-etm@openssh.com|hmac-sha1-96-etm@openssh.com|umac-64-etm@openssh.com|umac-128-etm@openssh.com)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==186==' 
/usr/sbin/sshd -T | /bin/grep -i 'kexalgorithms' | /bin/grep -oP '((diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==187==' 
/usr/sbin/sshd -T | /bin/grep clientaliveinterval
echo '==188==' 
/usr/sbin/sshd -T | /bin/grep clientalivecountmax
echo '==189==' 
/usr/sbin/sshd -T | /bin/grep logingracetime
echo '==190==' 
/usr/bin/grep -E '^[[:space:]]*minclass' /etc/security/pwquality.conf | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==191==' 
/usr/bin/grep -E '^[[:space:]]*minclass[[:space:]]*=[[:space:]]*4' /etc/security/pwquality.conf | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==192==' 
/usr/bin/grep -P '^[[:space:]]*\Scredit[[:space:]]*=[[:space:]]*-[1-9]' /etc/security/pwquality.conf | /usr/bin/sed ':a;$!{N;s/\n/ /;ba;}' | /usr/bin/grep -P '(?=.*?dcredit).*(?=.*?ucredit).*(?=.*?ocredit).*(?=.*?lcredit)' | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==193==' 
/bin/grep -P '^[\s]*auth[\s]+required[\s]+pam_tally2\.so[\s]*' /etc/pam.d/common-auth | /bin/grep -P '(?=.*?onerr=fail).*(?=.*?audit).*(?=.*?silent).*(?=.*?deny=@PAM_DENY_VALUE@).*(?=.*?unlock_time=@PAM_LOCKOUT_VALUE@)' | /usr/bin/awk '{print} END {if (NR != 0) print "pass" ; else print "fail"}'
echo '==194==' 
/usr/sbin/useradd -D | /bin/grep INACTIVE
echo '==195==' 
for user in $(cat /etc/shadow | cut -d: -f1); do expiry=$(date -d "$(chage --list $user | grep -Poi 'Last password change\s*\:[\s]*\K((Jan|Feb|Mar|Apr|May|Jun|Jul|Aug|Sep|Oct|Nov|Dec)[\s]+[0-9]{1,2}, 2[0-9]{3})$')" +%s); today=$(date +%s); if [ $expiry -gt $today ]; then echo "$user expiry date is in future"; fi ; done | /usr/bin/awk '{print} END {if (NR == 0) print "pass"; else print "fail"}'
echo '==196==' 
/usr/bin/awk -F: '($1!="root" && $1!~\/^\+\/ && $3&lt;'"$(/usr/bin/awk '\/^[\s]*UID_MIN\/{print $2}' /etc/login\.defs)"') {print $1}' /etc/passwd | /usr/bin/xargs -I '{}' /usr/bin/passwd -S '{}' | /usr/bin/awk '($2!="L" && $2!="LK") {print $1}' | /usr/bin/awk '{print} END {if (NR == 0) print "pass" ; else print "fail"}'
echo '==197==' 
/bin/grep -v "console" /etc/securetty | /usr/bin/awk '{ print } END { if (NR==0) print "none" }'
echo '==198==' 
/bin/grep pam_wheel.so /etc/pam.d/su; /bin/cat /etc/group
echo '==199==' 
/bin/cat /etc/shadow | /usr/bin/awk -F : '($2 == "") { print $1 " does not have a password."}'| /usr/bin/awk '{print} END {if (NR == 0) print "none"'}
echo '==200==' 
/bin/cat /etc/passwd | /bin/egrep -v '^(root|halt|sync|shutdown)' | /usr/bin/awk -F: '($7 != "/usr/sbin/nologin" && $7 != "/bin/false") { print $1 " " $6 }' | while read user dir; do if [ ! -d "$dir" ]; then /bin/echo "The home directory ($dir) of user $user does not exist."; fi; done | /usr/bin/awk '{ print } END { if(NR==0) { print "No results found" } }'
echo '==201==' 
for dir in $(/usr/bin/cat /etc/passwd | /usr/bin/egrep -v '(root|halt|sync|shutdown)' | /usr/bin/awk -F: '($7 != "/sbin/nologin") { print $6 }'); do if [ -f "$dir/.netrc" ]; then fileperm=$(ls -ld $dir/.netrc | cut -f1 -d" "); if [ $(/usr/bin/echo $fileperm | cut -c5) != "-" ]; then /usr/bin/echo "Group Read set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c6) != "-" ]; then /usr/bin/echo "Group Write set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c7) != "-" ]; then /usr/bin/echo "Group Execute set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c8) != "-" ]; then /usr/bin/echo "Other Read set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c9) != "-" ]; then /usr/bin/echo "Other Write set on $dir/.netrc"; fi; if [ $(/usr/bin/echo $fileperm | cut -c10) != "-" ]; then /usr/bin/echo "Other Execute set on $dir/.netrc"; fi; fi; done | /usr/bin/awk '{ print } END { if (NR==0) print "All .netrc files are not group or world accessible" }'
echo '==202==' 
/usr/bin/cat /etc/passwd | /usr/bin/egrep -v '^(root|halt|sync|shutdown)' | /usr/bin/awk -F: '($7 != "/sbin/nologin") { print $1 " " $3 " " $6 }' | while read user uid dir; do if [ -f "$dir/.rhosts" ]; then /usr/bin/echo ".rhosts file $dir/.rhosts exists"; fi; done | /usr/bin/awk '{ print } END { if (NR==0) print "No .rhosts files found" }'
echo '==203==' 
/usr/bin/awk -F: 'FILENAME == "/etc/group" && $1 == "shadow" { gid=$3; if ($4!="") { print "secondary "$4; f=1 } } FILENAME == "/etc/passwd" && $4 == gid { print "primary "$1; f=1 } END { if (!f) print "shadow group empty" }' /etc/group /etc/passwd;