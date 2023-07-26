#!/bin/bash
echo "====" 
/sbin/modprobe -n -v freevxfs | /usr/bin/awk '{print} END {if (NR == 0) print fail}'
echo "===="
/usr/sbin/lsmod | /bin/grep freevxfs | /usr/bin/awk '{print} END {if (NR == 0) print pass ; else print fail}'
echo "===="
/sbin/modprobe -n -v jffs2 | /usr/bin/awk '{print} END {if (NR == 0) print fail}'
echo "===="
/sbin/lsmod | /bin/grep jffs2 | /usr/bin/awk '{print} END {if (NR == 0) print pass ; else print fail}'
echo "===="
/sbin/modprobe -n -v hfs | /usr/bin/awk '{print} END {if (NR == 0) print fail}'
echo "===="
/sbin/lsmod | /bin/grep hfs | /usr/bin/awk '{print} END {if (NR == 0) print pass ; else print fail}'
echo "===="
/sbin/modprobe -n -v hfsplus  | /usr/bin/awk '{print} END {if (NR == 0) print fail}'
echo "===="
/sbin/lsmod | /bin/grep hfsplus | /usr/bin/awk '{print} END {if (NR == 0) print pass ; else print fail}'
echo "===="
/sbin/modprobe -n -v squashfs | /usr/bin/awk '{print} END {if (NR == 0) print fail}'
echo "===="
/sbin/lsmod | /bin/grep squashfs | /usr/bin/awk '{print} END {if (NR == 0) print pass ; else print fail}'
echo "===="
/sbin/modprobe -n -v udf | /usr/bin/awk '{print} END {if (NR == 0) print fail}'
