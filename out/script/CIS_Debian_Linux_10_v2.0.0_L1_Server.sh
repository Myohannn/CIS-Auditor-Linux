#!/bin/bash

echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
   l_mname="cramfs" # set module name
   l_mtype="fs" # set module type
   l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
   l_mpath="/lib/modules/**/kernel/$l_mtype"
   l_mpname="$(tr '-' '_' <<< "$l_mname")"
   l_mndir="$(tr '-' '/' <<< "$l_mname")"

   module_loadable_chk()
   {
      # Check if the module is currently loadable
      l_loadable="$(modprobe -n -v "$l_mname")"
      [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
   }
   module_loaded_chk()
   {
      # Check if the module is currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
   }
   module_deny_chk()
   {
      # Check if the module is deny listed
      l_dl="y"
      if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   # Check if the module exists on the system
   for l_mdir in $l_mpath; do
      if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
         l_output3="$l_output3\n  - \"$l_mdir\""
         [ "$l_dl" != "y" ] && module_deny_chk
         if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
         fi
      else
         l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
      fi
   done
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
   l_mname="freevxfs" # set module name
   l_mtype="fs" # set module type
   l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
   l_mpath="/lib/modules/**/kernel/$l_mtype"
   l_mpname="$(tr '-' '_' <<< "$l_mname")"
   l_mndir="$(tr '-' '/' <<< "$l_mname")"

   module_loadable_chk()
   {
      # Check if the module is currently loadable
      l_loadable="$(modprobe -n -v "$l_mname")"
      [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
   }
   module_loaded_chk()
   {
      # Check if the module is currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
   }
   module_deny_chk()
   {
      # Check if the module is deny listed
      l_dl="y"
      if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   # Check if the module exists on the system
   for l_mdir in $l_mpath; do
      if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
         l_output3="$l_output3\n  - \"$l_mdir\""
         [ "$l_dl" != "y" ] && module_deny_chk
         if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
         fi
      else
         l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
      fi
   done
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
   l_mname="jffs2" # set module name
   l_mtype="fs" # set module type
   l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
   l_mpath="/lib/modules/**/kernel/$l_mtype"
   l_mpname="$(tr '-' '_' <<< "$l_mname")"
   l_mndir="$(tr '-' '/' <<< "$l_mname")"

   module_loadable_chk()
   {
      # Check if the module is currently loadable
      l_loadable="$(modprobe -n -v "$l_mname")"
      [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
   }
   module_loaded_chk()
   {
      # Check if the module is currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
   }
   module_deny_chk()
   {
      # Check if the module is deny listed
      l_dl="y"
      if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   # Check if the module exists on the system
   for l_mdir in $l_mpath; do
      if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
         l_output3="$l_output3\n  - \"$l_mdir\""
         [ "$l_dl" != "y" ] && module_deny_chk
         if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
         fi
      else
         l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
      fi
   done
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
   l_mname="hfs" # set module name
   l_mtype="fs" # set module type
   l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
   l_mpath="/lib/modules/**/kernel/$l_mtype"
   l_mpname="$(tr '-' '_' <<< "$l_mname")"
   l_mndir="$(tr '-' '/' <<< "$l_mname")"

   module_loadable_chk()
   {
      # Check if the module is currently loadable
      l_loadable="$(modprobe -n -v "$l_mname")"
      [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
   }
   module_loaded_chk()
   {
      # Check if the module is currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
   }
   module_deny_chk()
   {
      # Check if the module is deny listed
      l_dl="y"
      if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   # Check if the module exists on the system
   for l_mdir in $l_mpath; do
      if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
         l_output3="$l_output3\n  - \"$l_mdir\""
         [ "$l_dl" != "y" ] && module_deny_chk
         if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
         fi
      else
         l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
      fi
   done
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
   l_mname="hfsplus" # set module name
   l_mtype="fs" # set module type
   l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
   l_mpath="/lib/modules/**/kernel/$l_mtype"
   l_mpname="$(tr '-' '_' <<< "$l_mname")"
   l_mndir="$(tr '-' '/' <<< "$l_mname")"

   module_loadable_chk()
   {
      # Check if the module is currently loadable
      l_loadable="$(modprobe -n -v "$l_mname")"
      [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
   }
   module_loaded_chk()
   {
      # Check if the module is currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
   }
   module_deny_chk()
   {
      # Check if the module is deny listed
      l_dl="y"
      if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   # Check if the module exists on the system
   for l_mdir in $l_mpath; do
      if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
         l_output3="$l_output3\n  - \"$l_mdir\""
         [ "$l_dl" != "y" ] && module_deny_chk
         if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
         fi
      else
         l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
      fi
   done
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
/usr/bin/findmnt -nk /tmp
echo '==|==' 
/usr/bin/findmnt -nk /tmp
echo '==|==' 
/usr/bin/findmnt -nk /tmp
echo '==|==' 
/usr/bin/findmnt -nk /tmp
echo '==|==' 
/usr/bin/findmnt -nk /var | /usr/bin/grep -v 'nodev' | /usr/bin/awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var | /usr/bin/grep -v 'nosuid' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/tmp | /usr/bin/grep -v 'nodev' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/tmp | /usr/bin/grep -v 'noexec' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/tmp | /usr/bin/grep -v 'nosuid' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/log | /usr/bin/grep -v 'nodev' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/log | /usr/bin/grep -v 'noexec' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/log | /usr/bin/grep -v 'nosuid' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/log/audit | /usr/bin/grep -v 'nodev' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/log/audit | /usr/bin/grep -v 'noexec' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /var/log/audit | /usr/bin/grep -v 'nosuid' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /home | /usr/bin/grep -v 'nodev' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /home | /usr/bin/grep -v 'nosuid' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /dev/shm | /usr/bin/grep -v 'nodev' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /dev/shm | /usr/bin/grep -v 'noexec' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/findmnt -nk /dev/shm | /usr/bin/grep -v 'nosuid' | awk '{ print } END { if (NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_dl="" # Unset output variables
   l_mname="usb-storage" # set module name
   l_mtype="drivers" # set module type
   l_searchloc="/lib/modprobe.d/*.conf /usr/local/lib/modprobe.d/*.conf /run/modprobe.d/*.conf /etc/modprobe.d/*.conf"
   l_mpath="/lib/modules/**/kernel/$l_mtype"
   l_mpname="$(tr '-' '_' <<< "$l_mname")"
   l_mndir="$(tr '-' '/' <<< "$l_mname")"
   module_loadable_chk()
   {
      # Check if the module is currently loadable
      l_loadable="$(modprobe -n -v "$l_mname")"
      [ "$(wc -l <<< "$l_loadable")" -gt "1" ] && l_loadable="$(grep -P -- "(^\h*install|\b$l_mname)\b" <<< "$l_loadable")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
   }
   module_loaded_chk()
   {
      # Check if the module is currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
   }
   module_deny_chk()
   {
      # Check if the module is deny listed
      l_dl="y"
      if modprobe --showconfig | grep -Pq -- '^\h*blacklist\h+'"$l_mpname"'\b'; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pls -- "^\h*blacklist\h+$l_mname\b" $l_searchloc)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   # Check if the module exists on the system
   for l_mdir in $l_mpath; do
      if [ -d "$l_mdir/$l_mndir" ] && [ -n "$(ls -A $l_mdir/$l_mndir)" ]; then
         l_output3="$l_output3\n  - \"$l_mdir\""
         [ "$l_dl" != "y" ] && module_deny_chk
         if [ "$l_mdir" = "/lib/modules/$(uname -r)/kernel/$l_mtype" ]; then
            module_loadable_chk
            module_loaded_chk
         fi
      else
         l_output="$l_output\n - module: \"$l_mname\" doesn't exist in \"$l_mdir\""
      fi
   done
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_output3" ] && echo -e "\n\n -- INFO --\n - module: \"$l_mname\" exists in:$l_output3"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
/usr/bin/apt-get -s upgrade
echo '==|==' 
/usr/bin/apt-cache policy
echo '==|==' 
/usr/bin/apt-key list
echo '==|==' 
output="$(/usr/bin/grep -Eq '^root:\$[0-9]' /etc/shadow || echo "root is locked")"; echo $output | /usr/bin/awk '{print} END {if (NF != 0) print "Fail"; else print "Pass"}'
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=(kernel.randomize_va_space=2)
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("kernel.yama.ptrace_scope=1")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' prelink
echo '==|==' 
#!/bin/bash
{
   l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   if [ -n "$l_pkgoutput" ]; then
      l_output="" l_output2=""
      echo -e "$l_pkgoutput"
      # Look for existing settings and set variables if they exist
      l_gdmfile="$(grep -Prils '^\h*banner-message-enable\b' /etc/dconf/db/*.d)"
      if [ -n "$l_gdmfile" ]; then
         # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
         l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
         # Check if banner message is enabled
         if grep -Pisq '^\h*banner-message-enable=true\b' "$l_gdmfile"; then
            l_output="$l_output\n - The \"banner-message-enable\" option is enabled in \"$l_gdmfile\""
         else
            l_output2="$l_output2\n - The \"banner-message-enable\" option is not enabled"
         fi
         l_lsbt="$(grep -Pios '^\h*banner-message-text=.*$' "$l_gdmfile")"
         if [ -n "$l_lsbt" ]; then
            l_output="$l_output\n - The \"banner-message-text\" option is set in \"$l_gdmfile\"\n  - banner-message-text is set to:\n  - \"$l_lsbt\""
         else
            l_output2="$l_output2\n - The \"banner-message-text\" option is not set"
         fi
         if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
            l_output="$l_output\n - The \"$l_gdmprofile\" profile exists"
         else
            l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist"
         fi
         if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
            l_output="$l_output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
         else
            l_output2="$l_output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
         fi
      else
         l_output2="$l_output2\n - The \"banner-message-enable\" option isn't configured"
      fi
   else
      echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n  *** PASS ***\n"
   fi
   # Report results. If no failures output in l_output2, we pass
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   if [ -n "$l_pkgoutput" ]; then
      output="" output2=""
      l_gdmfile="$(grep -Pril '^\h*disable-user-list\h*=\h*true\b' /etc/dconf/db)"
      if [ -n "$l_gdmfile" ]; then
         output="$output\n - The \"disable-user-list\" option is enabled in \"$l_gdmfile\""
         l_gdmprofile="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_gdmfile")"
         if grep -Pq "^\h*system-db:$l_gdmprofile" /etc/dconf/profile/"$l_gdmprofile"; then
            output="$output\n - The \"$l_gdmprofile\" exists"
         else
            output2="$output2\n - The \"$l_gdmprofile\" doesn't exist"
         fi
         if [ -f "/etc/dconf/db/$l_gdmprofile" ]; then
            output="$output\n - The \"$l_gdmprofile\" profile exists in the dconf database"
         else
            output2="$output2\n - The \"$l_gdmprofile\" profile doesn't exist in the dconf database"
         fi
      else
         output2="$output2\n - The \"disable-user-list\" option is not enabled"
      fi
      if [ -z "$output2" ]; then
         echo -e "$l_pkgoutput\n- Audit result:\n   *** PASS: ***\n$output\n"
      else
         echo -e "$l_pkgoutput\n- Audit Result:\n   *** FAIL: ***\n$output2\n"
         [ -n "$output" ] && echo -e "$output\n"
      fi
   else
      echo -e "\n\n - GNOME Desktop Manager isn't installed\n - Recommendation is Not Applicable\n- Audit result:\n  *** PASS ***\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   # Check if GNMOE Desktop Manager is installed.  If package isn't installed, recommendation is Not Applicable\n
   # determine system's package manager
   l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   # Check if GDM is installed
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   # Check configuration (If applicable)
   if [ -n "$l_pkgoutput" ]; then
      l_output="" l_output2=""
      l_idmv="900" # Set for max value for idle-delay in seconds
      l_ldmv="5" # Set for max value for lock-delay in seconds
      # Look for idle-delay to determine profile in use, needed for remaining tests
      l_kfile="$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/)" # Determine file containing idle-delay key
      if [ -n "$l_kfile" ]; then
         # set profile name (This is the name of a dconf database)
         l_profile="$(awk -F'/' '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")" #Set the key profile name
         l_pdbdir="/etc/dconf/db/$l_profile.d" # Set the key file dconf db directory
         # Confirm that idle-delay exists, includes unit32, and value is between 1 and max value for idle-delay
         l_idv="$(awk -F 'uint32' '/idle-delay/{print $2}' "$l_kfile" | xargs)"
         if [ -n "$l_idv" ]; then
            [ "$l_idv" -gt "0" -a "$l_idv" -le "$l_idmv" ] && l_output="$l_output\n - The \"idle-delay\" option is set to \"$l_idv\" seconds in \"$l_kfile\""
            [ "$l_idv" = "0" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" (disabled) in \"$l_kfile\""
            [ "$l_idv" -gt "$l_idmv" ] && l_output2="$l_output2\n - The \"idle-delay\" option is set to \"$l_idv\" seconds (greater than $l_idmv) in \"$l_kfile\""
         else
            l_output2="$l_output2\n - The \"idle-delay\" option is not set in \"$l_kfile\""
         fi
         # Confirm that lock-delay exists, includes unit32, and value is between 0 and max value for lock-delay
         l_ldv="$(awk -F 'uint32' '/lock-delay/{print $2}' "$l_kfile" | xargs)"
         if [ -n "$l_ldv" ]; then
            [ "$l_ldv" -ge "0" -a "$l_ldv" -le "$l_ldmv" ] && l_output="$l_output\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds in \"$l_kfile\""
            [ "$l_ldv" -gt "$l_ldmv" ] && l_output2="$l_output2\n - The \"lock-delay\" option is set to \"$l_ldv\" seconds (greater than $l_ldmv) in \"$l_kfile\""
         else
            l_output2="$l_output2\n - The \"lock-delay\" option is not set in \"$l_kfile\""
         fi
         # Confirm that dconf profile exists
         if grep -Psq "^\h*system-db:$l_profile" /etc/dconf/profile/*; then
            l_output="$l_output\n - The \"$l_profile\" profile exists"
         else
            l_output2="$l_output2\n - The \"$l_profile\" doesn't exist"
         fi
         # Confirm that dconf profile database file exists
         if [ -f "/etc/dconf/db/$l_profile" ]; then
            l_output="$l_output\n - The \"$l_profile\" profile exists in the dconf database"
         else
            l_output2="$l_output2\n - The \"$l_profile\" profile doesn't exist in the dconf database"
         fi
      else
         l_output2="$l_output2\n - The \"idle-delay\" option doesn't exist, remaining tests skipped"
      fi
   else
      l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n  - Recommendation is not applicable"
   fi
   # Report results. If no failures output in l_output2, we pass
   [ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   # Check if GNOME Desktop Manager is installed.  If package isn't installed, recommendation is Not Applicable\n
   # determine system's package manager
   l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   # Check if GDM is installed
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   # Check configuration (If applicable)
   if [ -n "$l_pkgoutput" ]; then
      l_output="" l_output2=""
      # Look for idle-delay to determine profile in use, needed for remaining tests
      l_kfd="/etc/dconf/db/$(grep -Psril '^\h*idle-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
      l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*lock-delay\h*=\h*uint32\h+\d+\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
      if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
         if grep -Prilq '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd"; then
            l_output="$l_output\n - \"idle-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/session\/idle-delay\b' "$l_kfd")\""
         else
            l_output2="$l_output2\n - \"idle-delay\" is not locked"
         fi
      else
         l_output2="$l_output2\n - \"idle-delay\" is not set so it can not be locked"
      fi
      if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked
         if grep -Prilq '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2"; then
            l_output="$l_output\n - \"lock-delay\" is locked in \"$(grep -Pril '\/org\/gnome\/desktop\/screensaver\/lock-delay\b' "$l_kfd2")\""
         else
            l_output2="$l_output2\n - \"lock-delay\" is not locked"
         fi
      else
         l_output2="$l_output2\n - \"lock-delay\" is not set so it can not be locked"
      fi
   else
      l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n  - Recommendation is not applicable"
   fi
   # Report results. If no failures output in l_output2, we pass
	[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_pkgoutput="" l_output="" l_output2=""
   # Check if GNOME Desktop Manager is installed.  If package isn't installed, recommendation is Not Applicable\n
   # determine system's package manager
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   # Check if GDM is installed
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   # Check configuration (If applicable)
   if [ -n "$l_pkgoutput" ]; then
      echo -e "$l_pkgoutput"
      # Look for existing settings and set variables if they exist
      l_kfile="$(grep -Prils -- '^\h*automount\b' /etc/dconf/db/*.d)"
      l_kfile2="$(grep -Prils -- '^\h*automount-open\b' /etc/dconf/db/*.d)"
      # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
      if [ -f "$l_kfile" ]; then
         l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
      elif [ -f "$l_kfile2" ]; then
         l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile2")"
      fi
      # If the profile name exist, continue checks
      if [ -n "$l_gpname" ]; then
         l_gpdir="/etc/dconf/db/$l_gpname.d"
         # Check if profile file exists
         if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
            l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
         else
            l_output2="$l_output2\n - dconf database profile isn't set"
         fi
         # Check if the dconf database file exists
         if [ -f "/etc/dconf/db/$l_gpname" ]; then
            l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
         else
            l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist"
         fi
         # check if the dconf database directory exists
         if [ -d "$l_gpdir" ]; then
            l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst"
         else
            l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist"
         fi
         # check automount setting
         if grep -Pqrs -- '^\h*automount\h*=\h*false\b' "$l_kfile"; then
            l_output="$l_output\n - \"automount\" is set to false in: \"$l_kfile\""
         else
            l_output2="$l_output2\n - \"automount\" is not set correctly"
         fi
         # check automount-open setting
         if grep -Pqs -- '^\h*automount-open\h*=\h*false\b' "$l_kfile2"; then
            l_output="$l_output\n - \"automount-open\" is set to false in: \"$l_kfile2\""
         else
            l_output2="$l_output2\n - \"automount-open\" is not set correctly"
         fi
      else
         # Setings don't exist. Nothing further to check
         l_output2="$l_output2\n - neither \"automount\" or \"automount-open\" is set"
      fi
   else
      l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n  - Recommendation is not applicable"
   fi
   # Report results. If no failures output in l_output2, we pass
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   # Check if GNOME Desktop Manager is installed.  If package isn't installed, recommendation is Not Applicable\n
   # determine system's package manager
   l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   # Check if GDM is installed
   l_pcl="gdm gdm3" # Space seporated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   # Check configuration (If applicable)
   if [ -n "$l_pkgoutput" ]; then
      l_output="" l_output2=""
      # Look for idle-delay to determine profile in use, needed for remaining tests
      l_kfd="/etc/dconf/db/$(grep -Psril '^\h*automount\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
      l_kfd2="/etc/dconf/db/$(grep -Psril '^\h*automount-open\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
      if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
         if grep -Piq '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd"; then
            l_output="$l_output\n - \"automount\" is locked in \"$(grep -Pil '^\h*\/org/gnome\/desktop\/media-handling\/automount\b' "$l_kfd")\""
         else
            l_output2="$l_output2\n - \"automount\" is not locked"
         fi
      else
         l_output2="$l_output2\n - \"automount\" is not set so it can not be locked"
      fi
      if [ -d "$l_kfd2" ]; then # If key file directory doesn't exist, options can't be locked
         if grep -Piq '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2"; then
            l_output="$l_output\n - \"lautomount-open\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/automount-open\b' "$l_kfd2")\""
         else
            l_output2="$l_output2\n - \"automount-open\" is not locked"
         fi
      else
         l_output2="$l_output2\n - \"automount-open\" is not set so it can not be locked"
      fi
   else
      l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n  - Recommendation is not applicable"
   fi
   # Report results. If no failures output in l_output2, we pass
	[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_pkgoutput="" l_output="" l_output2=""
   # Check if GNOME Desktop Manager is installed.  If package isn't installed, recommendation is Not Applicable\n
   # determine system's package manager
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   # Check if GDM is installed
   l_pcl="gdm gdm3" # Space separated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
      echo -e "$l_pkgoutput"
   done
   # Check configuration (If applicable)
   if [ -n "$l_pkgoutput" ]; then
      echo -e "$l_pkgoutput"
      # Look for existing settings and set variables if they exist
      l_kfile="$(grep -Prils -- '^\h*autorun-never\b' /etc/dconf/db/*.d)"
      # Set profile name based on dconf db directory ({PROFILE_NAME}.d)
      if [ -f "$l_kfile" ]; then
         l_gpname="$(awk -F\/ '{split($(NF-1),a,".");print a[1]}' <<< "$l_kfile")"
      fi
      # If the profile name exist, continue checks
      if [ -n "$l_gpname" ]; then
         l_gpdir="/etc/dconf/db/$l_gpname.d"
         # Check if profile file exists
         if grep -Pq -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*; then
            l_output="$l_output\n - dconf database profile file \"$(grep -Pl -- "^\h*system-db:$l_gpname\b" /etc/dconf/profile/*)\" exists"
         else
            l_output2="$l_output2\n - dconf database profile isn't set"
         fi
         # Check if the dconf database file exists
         if [ -f "/etc/dconf/db/$l_gpname" ]; then
            l_output="$l_output\n - The dconf database \"$l_gpname\" exists"
         else
            l_output2="$l_output2\n - The dconf database \"$l_gpname\" doesn't exist"
         fi
         # check if the dconf database directory exists
         if [ -d "$l_gpdir" ]; then
            l_output="$l_output\n - The dconf directory \"$l_gpdir\" exitst"
         else
            l_output2="$l_output2\n - The dconf directory \"$l_gpdir\" doesn't exist"
         fi
         # check autorun-never setting
         if grep -Pqrs -- '^\h*autorun-never\h*=\h*true\b' "$l_kfile"; then
            l_output="$l_output\n - \"autorun-never\" is set to true in: \"$l_kfile\""
         else
            l_output2="$l_output2\n - \"autorun-never\" is not set correctly"
         fi
      else
         # Settings don't exist. Nothing further to check
         l_output2="$l_output2\n - \"autorun-never\" is not set"
      fi
   else
      l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n  - Recommendation is not applicable"
   fi
   # Report results. If no failures output in l_output2, we pass
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   # Check if GNOME Desktop Manager is installed.  If package isn't installed, recommendation is Not Applicable\n
   # determine system's package manager
   l_pkgoutput=""
   if command -v dpkg-query > /dev/null 2>&1; then
      l_pq="dpkg-query -W"
   elif command -v rpm > /dev/null 2>&1; then
      l_pq="rpm -q"
   fi
   # Check if GDM is installed
   l_pcl="gdm gdm3" # Space separated list of packages to check
   for l_pn in $l_pcl; do
      $l_pq "$l_pn" > /dev/null 2>&1 && l_pkgoutput="$l_pkgoutput\n - Package: \"$l_pn\" exists on the system\n - checking configuration"
   done
   # Check configuration (If applicable)
   if [ -n "$l_pkgoutput" ]; then
      l_output="" l_output2=""
      # Look for idle-delay to determine profile in use, needed for remaining tests
      l_kfd="/etc/dconf/db/$(grep -Psril '^\h*autorun-never\b' /etc/dconf/db/*/ | awk -F'/' '{split($(NF-1),a,".");print a[1]}').d" #set directory of key file to be locked
      if [ -d "$l_kfd" ]; then # If key file directory doesn't exist, options can't be locked
         if grep -Prisq '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd"; then
            l_output="$l_output\n - \"autorun-never\" is locked in \"$(grep -Pril '^\h*\/org/gnome\/desktop\/media-handling\/autorun-never\b' "$l_kfd")\""
         else
            l_output2="$l_output2\n - \"autorun-never\" is not locked"
         fi
      else
         l_output2="$l_output2\n - \"autorun-never\" is not set so it can not be locked"
      fi
   else
      l_output="$l_output\n - GNOME Desktop Manager package is not installed on the system\n  - Recommendation is not applicable"
   fi
   # Report results. If no failures output in l_output2, we pass
	[ -n "$l_pkgoutput" ] && echo -e "\n$l_pkgoutput"
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   output="" l_tsd="" l_sdtd="" chrony="" l_ntp=""
   dpkg-query -W chrony > /dev/null 2>&1 && l_chrony="y"
   dpkg-query -W ntp > /dev/null 2>&1 && l_ntp="y" || l_ntp=""
   systemctl list-units --all --type=service | grep -q 'systemd-timesyncd.service' && systemctl is-enabled systemd-timesyncd.service | grep -q 'enabled' && l_sdtd="y"
   if [[ "$l_chrony" = "y" && "$l_ntp" != "y" && "$l_sdtd" != "y" ]]; then
      l_tsd="chrony"
      output="$output\n- chrony is in use on the system"
   elif [[ "$l_chrony" != "y" && "$l_ntp" = "y" && "$l_sdtd" != "y" ]]; then
      l_tsd="ntp"
      output="$output\n- ntp is in use on the system"
   elif [[ "$l_chrony" != "y" && "$l_ntp" != "y" ]]; then
      if systemctl list-units --all --type=service | grep -q 'systemd-timesyncd.service' && systemctl is-enabled systemd-timesyncd.service | grep -Eq '(enabled|disabled|masked)'; then
         l_tsd="sdtd"
         output="$output\n- systemd-timesyncd is in use on the system"
      fi
   else
      [[ "$l_chrony" = "y" && "$l_ntp" = "y" ]] && output="$output\n- both chrony and ntp are in use on the system"
      [[ "$l_chrony" = "y" && "$l_sdtd" = "y" ]] && output="$output\n- both chrony and systemd-timesyncd are in use on the system"
      [[ "$l_ntp" = "y" && "$l_sdtd" = "y" ]] && output="$output\n- both ntp and systemd-timesyncd are in use on the system"
   fi
   if [ -n "$l_tsd" ]; then
      echo -e "\n- PASS:\n$output\n"
   else
      echo -e "\n- FAIL:\n$output\n"
   fi
}
echo '==|==' 
/usr/bin/ps -ef | /usr/bin/awk '(/[c]hronyd/ && $1!="_chrony") { print $1 }' | /usr/bin/awk '{ print } END { if(NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/ps -ef | /usr/bin/awk '(/[n]tpd/ && $1!="ntp") { print $1 }' | /usr/bin/awk '{ print } END { if(NR==0) print "Pass"; else print "Fail" }'
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' avahi-daemon
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' cups
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' isc-dhcp-server
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' slapd
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' nfs-kernel-server
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' bind9
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' vsftpd
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' apache2
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' samba
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' squid
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' snmpd
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' nis
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' dnsmasq
echo '==|==' 
/usr/bin/ss -lntu | /usr/bin/grep -P ':25\b' | /usr/bin/grep -Pv '\h+(127\.\0\.0\.1|\[?::1\]?):25\b' | /usr/bin/awk '{print} END {if (NR == 0) print "Pass" ; else print "Fail"}'
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' rsync
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' nis
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' rsh-client
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' talk
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' telnet
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' ldap-utils
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' rpcbind
echo '==|==' 
/usr/bin/ss -plntu
echo '==|==' 
/usr/bin/grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && echo "IPv6 is enabled" || echo "IPv6 is not enabled"
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   module_chk()
   {
      # Check how module will be loaded
      l_loadable="$(modprobe -n -v "$l_mname")"
      if grep -Pq -- '^\h*install \/bin\/(true|false)' <<< "$l_loadable"; then
         l_output="$l_output\n - module: \"$l_mname\" is not loadable: \"$l_loadable\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loadable: \"$l_loadable\""
      fi
      # Check is the module currently loaded
      if ! lsmod | grep "$l_mname" > /dev/null 2>&1; then
         l_output="$l_output\n - module: \"$l_mname\" is not loaded"
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is loaded"
      fi
      # Check if the module is deny listed
      if modprobe --showconfig | grep -Pq -- "^\h*blacklist\h+$l_mname\b"; then
         l_output="$l_output\n - module: \"$l_mname\" is deny listed in: \"$(grep -Pl -- "^\h*blacklist\h+$l_mname\b" /etc/modprobe.d/*)\""
      else
         l_output2="$l_output2\n - module: \"$l_mname\" is not deny listed"
      fi
   }
   if [ -n "$(find /sys/class/net/*/ -type d -name wireless)" ]; then
      l_dname=$(for driverdir in $(find /sys/class/net/*/ -type d -name wireless | xargs -0 dirname); do basename "$(readlink -f "$driverdir"/device/driver/module)";done | sort -u)
      for l_mname in $l_dname; do
         module_chk
      done
   fi
   # Report results. If no failures output in l_output2, we pass
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **"
      if [ -z "$l_output" ]; then
         echo -e "\n - System has no wireless NICs installed"
      else
         echo -e "\n$l_output\n"
      fi
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.conf.all.send_redirects=0" "net.ipv4.conf.default.send_redirects=0")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.ip_forward=0" "net.ipv6.conf.all.forwarding=0")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.conf.all.accept_source_route=0" "net.ipv4.conf.default.accept_source_route=0" "net.ipv6.conf.all.accept_source_route=0" "net.ipv6.conf.default.accept_source_route=0")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.conf.all.accept_redirects=0" "net.ipv4.conf.default.accept_redirects=0" "net.ipv6.conf.all.accept_redirects=0" "net.ipv6.conf.default.accept_redirects=0")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.conf.all.secure_redirects=0" "net.ipv4.conf.default.secure_redirects=0")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.conf.all.log_martians=1" "net.ipv4.conf.default.log_martians=1")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.icmp_echo_ignore_broadcasts=1")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.icmp_ignore_bogus_error_responses=1")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.conf.all.rp_filter=1" "net.ipv4.conf.default.rp_filter=1")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv4.tcp_syncookies=1")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_parlist=("net.ipv6.conf.all.accept_ra=0" "net.ipv6.conf.default.accept_ra=0")
   l_ufwscf="$([ -f /etc/default/ufw ] && awk -F= '/^\s*IPT_SYSCTL=/ {print $2}' /etc/default/ufw)"
   kernel_parameter_chk()
   {
      l_krp="$(sysctl "$l_kpname" | awk -F= '{print $2}' | xargs)" # Check running configuration
      if [ "$l_krp" = "$l_kpvalue" ]; then
         l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_krp\" in the running configuration"
      else
         l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_krp\" in the running configuration and should have a value of: \"$l_kpvalue\""
      fi
      unset A_out; declare -A A_out # Check durable setting (files)
      while read -r l_out; do
         if [ -n "$l_out" ]; then
            if [[ $l_out =~ ^\s*# ]]; then
               l_file="${l_out//# /}"
            else
               l_kpar="$(awk -F= '{print $1}' <<< "$l_out" | xargs)"
               [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_file")
            fi
         fi
      done < <(/usr/lib/systemd/systemd-sysctl --cat-config | grep -Po '^\h*([^#\n\r]+|#\h*\/[^#\n\r\h]+\.conf\b)')
      if [ -n "$l_ufwscf" ]; then # Account for systems with UFW (Not covered by systemd-sysctl --cat-config)
         l_kpar="$(grep -Po "^\h*$l_kpname\b" "$l_ufwscf" | xargs)"
         l_kpar="${l_kpar//\//.}"
         [ "$l_kpar" = "$l_kpname" ] && A_out+=(["$l_kpar"]="$l_ufwscf")
      fi
      if (( ${#A_out[@]} > 0 )); then # Assess output from files and generate output
         while IFS="=" read -r l_fkpname l_fkpvalue; do
            l_fkpname="${l_fkpname// /}"; l_fkpvalue="${l_fkpvalue// /}"
            if [ "$l_fkpvalue" = "$l_kpvalue" ]; then
               l_output="$l_output\n - \"$l_kpname\" is correctly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\"\n"
            else
               l_output2="$l_output2\n - \"$l_kpname\" is incorrectly set to \"$l_fkpvalue\" in \"$(printf '%s' "${A_out[@]}")\" and should have a value of: \"$l_kpvalue\"\n"
            fi
         done < <(grep -Po -- "^\h*$l_kpname\h*=\h*\H+" "${A_out[@]}")
      else
         l_output2="$l_output2\n - \"$l_kpname\" is not set in an included file\n   ** Note: \"$l_kpname\" May be set in a file that's ignored by load procedure **\n"
      fi
   }
   while IFS="=" read -r l_kpname l_kpvalue; do # Assess and check parameters
      l_kpname="${l_kpname// /}"; l_kpvalue="${l_kpvalue// /}"
      if ! grep -Pqs '^\h*0\b' /sys/module/ipv6/parameters/disable && grep -q '^net.ipv6.' <<< "$l_kpname"; then
         l_output="$l_output\n - IPv6 is disabled on the system, \"$l_kpname\" is not applicable"
      else
         kernel_parameter_chk
      fi
   done < <(printf '%s\n' "${a_parlist[@]}")
   if [ -z "$l_output2" ]; then # Provide output from checks
      echo -e "\n- Audit Result:\n  ** PASS **\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "\n- Correctly set:\n$l_output\n"
   fi
}
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' ufw
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' iptables-persistent
echo '==|==' 
/usr/sbin/ufw status numbered
echo '==|==' 
#!/bin/bash
{
   unset a_ufwout;unset a_openports
   while read -r l_ufwport; do
      [ -n "$l_ufwport" ] && a_ufwout+=("$l_ufwport")
   done < <(ufw status verbose | grep -Po '^\h*\d+\b' | sort -u)
   while read -r l_openport; do
      [ -n "$l_openport" ] && a_openports+=("$l_openport")
   done < <(ss -tuln | awk '($5!~/%lo:/ && $5!~/127.0.0.1:/ && $5!~/\[?::1\]?:/) {split($5, a, ":"); print a[2]}' | sort -u)
   a_diff=("$(printf '%s\n' "${a_openports[@]}" "${a_ufwout[@]}" "${a_ufwout[@]}" | sort | uniq -u)")
   if [[ -n "${a_diff[*]}" ]]; then
      echo -e "\n- Audit Result:\n  ** FAIL **\n- The following port(s) don't have a rule in UFW: $(printf '%s\n' \\n"${a_diff[*]}")\n- End List"
   else
      echo -e "\n - Audit Passed -\n- All open ports have a rule in UFW\n"
   fi
}
echo '==|==' 
/usr/sbin/ufw status verbose | /usr/bin/grep Default:
echo '==|==' 
/usr/bin/dpkg -s nftables 2>&1 | /usr/bin/grep Status:
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' ufw
echo '==|==' 
/usr/sbin/iptables -L; /usr/sbin/ip6tables -L
echo '==|==' 
/usr/sbin/nft list tables
echo '==|==' 
/usr/sbin/nft list ruleset | /usr/bin/awk '/hook (input|output)/,/}/' | /usr/bin/grep -E 'ip protocol (tcp|udp|icmp) ct state'
echo '==|==' 
/bin/systemctl is-enabled nftables
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' nftables
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' ufw
echo '==|==' 
/sbin/iptables -L -v -n
echo '==|==' 
#!/bin/bash
{
	passing="" output="" output2=""
	iptrules=$(iptables -L INPUT -v -n)
	for oport in $(ss -4tuln | awk '($5!~/%lo:/ && $5!~/127.0.0.1:/) {split($5, a, ":"); print a[2]}'); do
		if [ -n "$oport" ]; then
			if echo $iptrules | grep -Eq ":$oport\b"; then
				[ -z "$passing" ] && passing=true
			else
				passing=false
				[ -z "$output" ] && output="The following open port(s) dont have a firewall rule: \"$oport\"" || output="$output, \"$oport\""
			fi
		fi
	done
	if [ -z "$passing" ] && [ -z "$output" ]; then
		passing=true
		output2="No open ports foud on the system"
	fi

	# If the tests both pass, passing is set to true.  If so, we pass
	if [ "$passing" = true ]; then
		echo "PASSED: All open ports have a firewall rule"
		[ -n "$output2" ] && echo "$output2"
	else
		# print the reason why we are failing
		echo "FAILED: $output"
	fi
}
echo '==|==' 
/sbin/ip6tables -L -v -n
echo '==|==' 
#!/bin/bash
{
passing="" output="" output2=""

ip6trules=$(ip6tables -L INPUT -v -n)
for oport in $(ss -6tuln | awk '($2~/(LISTEN|UNCONN|ESTAB)/ && $5!~/\{?::1\]?:/){print}' | sed -E 's/^.*:([0-9]+)\s+.*$/\1/'); do
	if [ -n "$oport" ]; then
		if echo $ip6trules | grep -Eq ":$oport\b"; then
			[ -z "$passing" ] && passing=true
		else
			passing=false
			[ -z "$output" ] && output="The following open port(s) dont have a firewall rule: \"$oport\"" || output="$output, \"$oport\""
		fi
	fi
done
if [ -z "$passing" ] && [ -z "$output" ]; then
	passing=true
	output2="No open ports foud on the system"
fi

# If the tests both pass, passing is set to true.  If so, we pass
if [ "$passing" = true ]; then
	echo "PASSED: All open ports have a firewall rule"
	[ -n "$output2" ] && echo "$output2"
    echo "${XCCDF_RESULT_PASS:-101}"
else
    # print the reason why we are failing
    echo "FAILED: $output"
    echo "${XCCDF_RESULT_FAIL:-102}"
fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   if dpkg-query -W cron > /dev/null 2>&1; then
      l_file="/etc/cron.allow"
      [ -e /etc/cron.deny ] && l_output2="$l_output2\n  - cron.deny exists"
      if [ ! -e /etc/cron.allow ]; then
         l_output2="$l_output2\n  - cron.allow doesn't exist"
      else
         l_mask='0137'
         l_maxperm="$( printf '%o' $(( 0777 & ~$l_mask)) )"
         while read l_mode l_fown l_fgroup; do
            if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
               l_output2="$l_output2\n  - \"$l_file\" is mode: \"$l_mode\" (should be mode: \"$l_maxperm\" or more restrictive)"
            else
               l_output="$l_output\n  - \"$l_file\" is correctly set to mode: \"$l_mode\""
            fi
            if [ "$l_fown" != "root" ]; then
               l_output2="$l_output2\n  - \"$l_file\" is owned by user \"$l_fown\" (should be owned by \"root\")"
            else
               l_output="$l_output\n  - \"$l_file\" is correctly owned by user: \"$l_fown\""
            fi
            if [  "$l_fgroup" != "crontab" ]; then
               l_output2="$l_output2\n  - \"$l_file\" is owned by group: \"$l_fgroup\" (should be owned by group: \"crontab\")"
            else
               l_output="$l_output\n  - \"$l_file\" is correctly owned by group: \"$l_fgroup\""
            fi
         done < <(stat -Lc '%#a %U %G' "$l_file")
      fi
   else
      l_output="$l_output\n  - cron is not installed on the system"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:$l_output2\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   if dpkg-query -W at > /dev/null 2>&1; then
      l_file="/etc/at.allow"
      [ -e /etc/at.deny ] && l_output2="$l_output2\n  - at.deny exists"
      if [ ! -e /etc/at.allow ]; then
         l_output2="$l_output2\n  - at.allow doesn't exist"
      else
         l_mask='0137'
         l_maxperm="$( printf '%o' $(( 0777 & ~$l_mask)) )"
         while read l_mode l_fown l_fgroup; do
            if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
               l_output2="$l_output2\n  - \"$l_file\" is mode: \"$l_mode\" (should be mode: \"$l_maxperm\" or more restrictive)"
            else
               l_output="$l_output\n  - \"$l_file\" is correctly set to mode: \"$l_mode\""
            fi
            if [ "$l_fown" != "root" ]; then
               l_output2="$l_output2\n  - \"$l_file\" is owned by user \"$l_fown\" (should be owned by \"root\")"
            else
               l_output="$l_output\n  - \"$l_file\" is correctly owned by user: \"$l_fown\""
            fi
            if [ "$l_fgroup" != "root" ]; then
               l_output2="$l_output2\n  - \"$l_file\" is owned by group: \"$l_fgroup\" (should be owned by group: \"root\")"
            else
               l_output="$l_output\n  - \"$l_file\" is correctly owned by group: \"$l_fgroup\""
            fi
         done < <(stat -Lc '%#a %U %G' "$l_file")
      fi
   else
      l_output="$l_output\n  - at is not installed on the system"
   fi
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - Reason(s) for audit failure:$l_output2\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   l_skgn="ssh_keys" # Group designated to own openSSH keys
   l_skgid="$(awk -F: '($1 == "'"$l_skgn"'"){print $3}' /etc/group)" # Get gid of group
   [ -n "$l_skgid" ] && l_agroup="(root|$l_skgn)" || l_agroup="root"
   unset a_skarr && a_skarr=() # Clear and initialize array
   while IFS= read -r -d $'\0' l_file; do # Loop to populate array
      if grep -Pq ':\h+OpenSSH\h+private\h+key\b' <<< "$(file "$l_file")"; then
         a_skarr+=("$(stat -Lc '%n^%#a^%U^%G^%g' "$l_file")")
      fi
   done < <(find -L /etc/ssh -xdev -type f -print0)
   while IFS="^" read -r l_file l_mode l_owner l_group l_gid; do
   echo "File: \"$l_file\" Mode: \"$l_mode\" Owner: \"$l_owner\" Group: \"$l_group\" GID: \"$l_gid\""
      l_out2=""
      [ "$l_gid" = "$l_skgid" ] && l_pmask="0137" || l_pmask="0177"
      l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
      if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
         l_out2="$l_out2\n  - Mode: \"$l_mode\" should be mode: \"$l_maxperm\" or more restrictive"
      fi
      if [ "$l_owner" != "root" ]; then
         l_out2="$l_out2\n  - Owned by: \"$l_owner\" should be owned by \"root\""
      fi
      if [[ ! "$l_group" =~ $l_agroup ]]; then
         l_out2="$l_out2\n  - Owned by group \"$l_group\" should be group owned by: \"${l_agroup//|/ or }\""
      fi
      if [ -n "$l_out2" ]; then
         l_output2="$l_output2\n - File: \"$l_file\"$l_out2"
      else
         l_output="$l_output\n - File: \"$l_file\"\n  - Correct: mode ($l_mode), owner ($l_owner), and group owner ($l_group) configured"
      fi
   done <<< "$(printf '%s\n' "${a_skarr[@]}")"
   unset a_skarr
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  *** PASS ***\n- * Correctly set * :\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n"
      [ -n "$l_output" ] && echo -e " - * Correctly set * :\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   l_pmask="0133"
   awk '{print}' <<< "$(find -L /etc/ssh -xdev -type f -exec stat -Lc "%n %#a %U %G" {} +)" | (while read -r  l_file l_mode l_owner l_group; do
      if file "$l_file" | grep -Pq ':\h+OpenSSH\h+(\H+\h+)?public\h+key\b'; then
         l_maxperm="$( printf '%o' $(( 0777 & ~$l_pmask )) )"
         if [ $(( $l_mode & $l_pmask )) -gt 0 ]; then
            l_output2="$l_output2\n - Public key file: \"$l_file\" is mode \"$l_mode\" should be mode: \"$l_maxperm\" or more restrictive"
         else
            l_output="$l_output\n - Public key file: \"$l_file\" is mode \"$l_mode\" should be mode: \"$l_maxperm\" or more restrictive"
         fi
         if [ "$l_owner" != "root" ]; then
            l_output2="$l_output2\n - Public key file: \"$l_file\" is owned by: \"$l_owner\" should be owned by \"root\""
         else
            l_output="$l_output\n - Public key file: \"$l_file\" is owned by: \"$l_owner\" should be owned by \"root\""
         fi
         if [ "$l_group" != "root" ]; then
            l_output2="$l_output2\n - Public key file: \"$l_file\" is owned by group \"$l_group\" should belong to group \"root\"\n"
         else
            l_output="$l_output\n - Public key file: \"$l_file\" is owned by group \"$l_group\" should belong to group \"root\"\n"
         fi
      fi
   done
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  *** PASS ***\n$l_output"
   else
      echo -e "\n- Audit Result:\n  *** FAIL ***\n$l_output2\n\n  - Correctly set:\n$l_output"
   fi
   )
}
echo '==|==' 
/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i ciphers | /bin/grep -oP '((3des-cbc|aes128-cbc|aes192-cbc|aes256-cbc|rijndael-cbc@lysator.liu.se)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass"; else print $0 }'
echo '==|==' 
/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | /bin/grep -i 'MACs' | /bin/grep -P '((hmac-md5|hmac-md5-96|hmac-ripemd160|hmac-sha1|hmac-sha1-96|hmac-sha1-96|umac-64@openssh.com|hmac-md5-etm@openssh.com|hmac-md5-96-etm@openssh.com|hmac-ripemd160-etm@openssh.com|hmac-sha1-etm@openssh.com|hmac-sha1-96-etm@openssh.com|umac-64-etm@openssh.com)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass" }'
echo '==|==' 
/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i kexalgorithms | /bin/grep -P '((diffie-hellman-group1-sha1|diffie-hellman-group14-sha1|diffie-hellman-group-exchange-sha1)[,]?)+' | /bin/awk '{print} END {if (NR == 0) print "pass" }'
echo '==|==' 
/usr/sbin/sshd -T -C user=root -C host="$(hostname)" -C addr="$(grep $(hostname) /etc/hosts | awk '{print $1}')" | grep -i banner | /usr/bin/awk '{print} END {if (NR == 0) print "Configuration not found"}'
echo '==|==' 
/usr/bin/sudo -V | /usr/bin/grep "Authentication timestamp timeout:"
echo '==|==' 
sugroup=$(/usr/bin/grep -Pi '^\h*auth\h+(?:required|requisite)\h+pam_wheel\.so\h+(?:[^#\n\r]+\h+)?((?!\2)(use_uid\b|group=\H+\b))\h+(?:[^#\n\r]+\h+)?((?!\1)(use_uid\b|group=\H+\b))(\h+.*)?$' /etc/pam.d/su | /usr/bin/sed -n 's/^.*\(group=[A-Za-z0-9-]\+\).*$/\1/p' | /usr/bin/cut -d= -f2); [ -z $sugroup ] && echo "Fail - group or use_uid not found in /etc/pam.d/su" || /usr/bin/grep $sugroup /etc/group
echo '==|==' 
echo Manual
echo '==|==' 
#!/bin/bash
{
   l_output2=""
   while read -r l_user; do
      l_change="$(chage --list $l_user | awk -F: '($1 ~ /^\s*Last\s+password\s+change/ && $2 !~ /never/){print $2}' | xargs)"
      if [[ "$(date -d "$l_change" +%s)" -gt "$(date +%s)" ]]; then
         l_output2="$l_output2\n  - User: \"$l_user\" last password change is in the future \"$l_change\""
      fi
   done < <(awk -F: '($2 ~ /^[^*!xX\n\r][^\n\r]+/){print $1}' /etc/shadow)
   if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
      echo -e "\n- Audit Result:\n  ** PASS **\n - All user password changes are in the past \n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :$l_output2\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$"
   a_users=(); a_ulock=() # initialize arrays
   while read -r l_user; do # Populate array with system accounts that have a valid login shell
      a_users+=("$l_user")
   done < <(awk -v pat="$l_valid_shells" -F: '($1!~/(root|sync|shutdown|halt|^\+)/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $(NF) ~ pat) { print $1 }' /etc/passwd)
   while read -r l_ulock; do # Populate array with system accounts that aren't locked
      a_ulock+=("$l_ulock")
   done < <(awk -v pat="$l_valid_shells" -F: '($1!~/(root|^\+)/ && $2!~/LK?/ && $3<'"$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"' && $(NF) ~ pat) { print $1 }' /etc/passwd)
   if ! (( ${#a_users[@]} > 0 )); then
      l_output="$l_output\n  - local system accounts login is disabled"
   else
      l_output2="$l_output2\n  - There are \"$(printf '%s' "${#a_users[@]}")\" system accounts with login enabled\n   - List of accounts:\n$(printf '%s\n' "${a_users[@]:0:$l_limit}")\n   - end of list\n"
   fi
   if ! (( ${#a_ulock[@]} > 0 )); then
      l_output="$l_output\n  - local system accounts are locked"
   else
      l_output2="$l_output2\n  - There are \"$(printf '%s' "${#a_ulock[@]}")\" system accounts that are not locked\n   - List of accounts:\n$(printf '%s\n' "${a_ulock[@]:0:$l_limit}")\n   - end of list\n"
   fi
   unset a_users; unset a_ulock # Remove arrays
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n - * Correctly configured * :\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
      [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   l_tmv_max="900"
   l_searchloc="/etc/bashrc /etc/bash.bashrc /etc/profile /etc/profile.d/*.sh"
   a_tmofile=()
   while read -r l_file; do
      [ -e "$l_file" ] && a_tmofile+=("$(readlink -f $l_file)")
   done < <(grep -PRils '^\h*([^#\n\r]+\h+)?TMOUT=\d+\b' $l_searchloc)
   if ! (( ${#a_tmofile[@]} > 0 )); then
      l_output2="$l_output2\n - TMOUT is not set"
   elif (( ${#a_tmofile[@]} > 1 )); then
      l_output2="$l_output2\n - TMOUT is set in multiple locations.\n  - List of files where TMOUT is set:\n$(printf '%s\n' "${a_tmofile[@]}")\n  - end of list\n"
   else
      for l_file in ${a_tmofile[@]}; do
         if (( "$(grep -Pci '^\h*([^#\n\r]+\h+)?TMOUT=\d+' "$l_file")" > 1 )); then
            l_output2="$l_output2\n - TMOUT is set multiple times in \"$l_file\""
         else
            l_tmv="$(grep -Pi '^\h*([^#\n\r]+\h+)?TMOUT=\d+' "$l_file" | grep -Po '\d+')"
            if (( "$l_tmv" > "$l_tmv_max" )); then
               l_output2="$l_output\n - TMOUT is \"$l_tmv\" in \"$l_file\"\n  - Should be \"$l_tmv_max\" or less and not \"0\""
            else
               l_output="$l_output\n- TMOUT is correctly set to \"$l_tmv\" in \"$l_file\""
               if grep -Piq '^\h*([^#\n\r]+\h+)?readonly\h+TMOUT\b' "$l_file"; then
                  l_output="$l_output\n- TMOUT is correctly set to \"readonly\" in \"$l_file\""
               else
                  l_output2="$l_output2\n- TMOUT is not set to \"readonly\""
               fi
               if grep -Piq '^(\h*|\h*[^#\n\r]+\h*;\h*)export\h+TMOUT\b' "$l_file"; then
                  l_output="$l_output\n- TMOUT is correctly set to \"export\" in \"$l_file\""
               else
                  l_output2="$l_output2\n- TMOUT is not set to \"export\""
               fi
            fi
         fi
      done
   fi
   unset a_tmofile # Remove array
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n - * Correctly configured * :\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
      [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n"
   fi
}
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' systemd-journal-remote
echo '==|==' 
/bin/systemctl is-enabled systemd-journal-upload.service
echo '==|==' 
/bin/systemctl is-enabled systemd-journal-remote.socket
echo '==|==' 
/bin/systemctl is-enabled systemd-journald.service
echo '==|==' 
/usr/bin/dpkg-query -W -f='${binary:Package}\t${Status}\t${db:Status-Status}' rsyslog
echo '==|==' 
/bin/systemctl is-enabled rsyslog | /usr/bin/awk '{print} END {if(NR==0) print "disabled" }'
echo '==|==' 
#!/bin/bash
{
   l_op2="" l_output2=""
   l_uidmin="$(awk '/^\s*UID_MIN/{print $2}' /etc/login.defs)"
   file_test_chk()
   {
      l_op2=""
      if [ $(( $l_mode & $perm_mask )) -gt 0 ]; then
         l_op2="$l_op2\n  - Mode: \"$l_mode\" should be \"$maxperm\" or more restrictive"
      fi
      if [[ ! "$l_user" =~ $l_auser ]]; then
         l_op2="$l_op2\n  - Owned by: \"$l_user\" and should be owned by \"${l_auser//|/ or }\""
      fi
      if [[ ! "$l_group" =~ $l_agroup ]]; then
         l_op2="$l_op2\n  - Group owned by: \"$l_group\" and should be group owned by \"${l_agroup//|/ or }\""
      fi
      [ -n "$l_op2" ] && l_output2="$l_output2\n - File: \"$l_fname\" is:$l_op2\n"
   }
   unset a_file && a_file=() # clear and initialize array
   # Loop to create array with stat of files that could possibly fail one of the audits
   while IFS= read -r -d $'\0' l_file; do
      [ -e "$l_file" ] && a_file+=("$(stat -Lc '%n^%#a^%U^%u^%G^%g' "$l_file")")
   done < <(find -L /var/log -type f \( -perm /0137 -o ! -user root -o ! -group root \) -print0)
   while IFS="^" read -r l_fname l_mode l_user l_uid l_group l_gid; do
      l_bname="$(basename "$l_fname")"
      case "$l_bname" in
         lastlog | lastlog.* | wtmp | wtmp.* | wtmp-* | btmp | btmp.* | btmp-* | README)
            perm_mask='0113'
            maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
            l_auser="root"
            l_agroup="(root|utmp)"
            file_test_chk
            ;;
         secure | auth.log | syslog | messages)
            perm_mask='0137'
            maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
            l_auser="(root|syslog)"
            l_agroup="(root|adm)"
            file_test_chk
            ;;
         SSSD | sssd)
            perm_mask='0117'
            maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
            l_auser="(root|SSSD)"
            l_agroup="(root|SSSD)"
            file_test_chk
            ;;
         gdm | gdm3)
            perm_mask='0117'
            maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
            l_auser="root"
            l_agroup="(root|gdm|gdm3)"
            file_test_chk
            ;;
         *.journal | *.journal~)
            perm_mask='0137'
            maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
            l_auser="root"
            l_agroup="(root|systemd-journal)"
            file_test_chk
            ;;
         *)
            perm_mask='0137'
            maxperm="$( printf '%o' $(( 0777 & ~$perm_mask)) )"
            l_auser="(root|syslog)"
            l_agroup="(root|adm)"
            if [ "$l_uid" -lt "$l_uidmin" ] && [ -z "$(awk -v grp="$l_group" -F: '$1==grp {print $4}' /etc/group)" ]; then
               if [[ ! "$l_user" =~ $l_auser ]]; then
                  l_auser="(root|syslog|$l_user)"
               fi
               if [[ ! "$l_group" =~ $l_agroup ]]; then
                  l_tst=""
                  while l_out3="" read -r l_duid; do
                     [ "$l_duid" -ge "$l_uidmin" ] && l_tst=failed
                  done <<< "$(awk -F: '$4=='"$l_gid"' {print $3}' /etc/passwd)"
                  [ "$l_tst" != "failed" ] && l_agroup="(root|adm|$l_group)"
               fi
            fi
            file_test_chk
            ;;
      esac
   done <<< "$(printf '%s\n' "${a_file[@]}")"
   unset a_file # Clear array
   # If all files passed, then we pass
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Results:\n ** Pass **\n- All files in \"/var/log/\" have appropriate permissions and ownership\n"
   else
      # print the reason why we are failing
      echo -e "\n- Audit Results:\n ** Fail **\n$l_output2"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   l_smask='01000'
   a_path=(); a_arr=(); a_file=(); a_dir=() # Initialize arrays
   a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*" -a ! -path "/sys/kernel/security/apparmor/*" -a ! -path "/snap/*" -a ! -path "/sys/fs/cgroup/memory/*")
   while read -r l_bfs; do
      a_path+=( -a ! -path ""$l_bfs"/*")
   done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')
   # Populate array with files that will possibly fail one of the audits
   while IFS= read -r -d $'\0' l_file; do
      [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
   done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) -perm -0002 -print0 2>/dev/null)
   while IFS="^" read -r l_fname l_mode; do # Test files in the array
      [ -f "$l_fname" ] && a_file+=("$l_fname") # Add WR files
      if [ -d "$l_fname" ]; then # Add directories w/o sticky bit
         [ ! $(( $l_mode & $l_smask )) -gt 0 ] && a_dir+=("$l_fname")
      fi
   done < <(printf '%s\n' "${a_arr[@]}")
   if ! (( ${#a_file[@]} > 0 )); then
      l_output="$l_output\n  - No world writable files exist on the local filesystem."
   else
      l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_file[@]}")\" World writable files on the system.\n   - The following is a list of World writable files:\n$(printf '%s\n' "${a_file[@]}")\n   - end of list\n"
   fi
   if ! (( ${#a_dir[@]} > 0 )); then
      l_output="$l_output\n  - Sticky bit is set on world writable directories on the local filesystem."
   else
      l_output2="$l_output2\n - There are \"$(printf '%s' "${#a_dir[@]}")\" World writable directories without the sticky bit on the system.\n   - The following is a list of World writable directories without the sticky bit:\n$(printf '%s\n' "${a_dir[@]}")\n   - end of list\n"
   fi
   unset a_path; unset a_arr; unset a_file; unset a_dir # Remove arrays
   # If l_output2 is empty, we pass
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n  ** PASS **\n - * Correctly configured * :\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
      [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_path=(); a_arr=(); a_nouser=(); a_nogroup=() # Initialize arrays
   a_path=(! -path "/run/user/*" -a ! -path "/proc/*" -a ! -path "*/containerd/*" -a ! -path "*/kubelet/pods/*")
   while read -r l_bfs; do
      a_path+=( -a ! -path ""$l_bfs"/*")
   done < <(findmnt -Dkerno fstype,target | awk '$1 ~ /^\s*(nfs|proc|smb)/ {print $2}')
   while IFS= read -r -d $'\0' l_file; do
      [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%U^%G' "$l_file")") && echo "Adding: $l_file"
   done < <(find / \( "${a_path[@]}" \) \( -type f -o -type d \) \( -nouser -o -nogroup \) -print0 2> /dev/null)
   while IFS="^" read -r l_fname l_user l_group; do # Test files in the array
      [ "$l_user" = "UNKNOWN" ] && a_nouser+=("$l_fname")
      [ "$l_group" = "UNKNOWN" ] && a_nogroup+=("$l_fname")
   done <<< "$(printf '%s\n' "${a_arr[@]}")"
   if ! (( ${#a_nouser[@]} > 0 )); then
      l_output="$l_output\n  - No unowned files or directories exist on the local filesystem."
   else
      l_output2="$l_output2\n  - There are \"$(printf '%s' "${#a_nouser[@]}")\" unowned files or directories on the system.\n   - The following is a list of unowned files and/or directories:\n$(printf '%s\n' "${a_nouser[@]}")\n   - end of list"
   fi
   if ! (( ${#a_nogroup[@]} > 0 )); then
      l_output="$l_output\n  - No ungrouped files or directories exist on the local filesystem."
   else
      l_output2="$l_output2\n  - There are \"$(printf '%s' "${#a_nogroup[@]}")\" ungrouped files or directories on the system.\n   - The following is a list of ungrouped files and/or directories:\n$(printf '%s\n' "${a_nogroup[@]}")\n   - end of list"
   fi
   unset a_path; unset a_arr ; unset a_nouser; unset a_nogroup # Remove arrays
   if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
      echo -e "\n- Audit Result:\n  ** PASS **\n - * Correctly configured * :\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
      [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output\n"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2=""
   a_arr=(); a_suid=(); a_sgid=() # initialize arrays
   # Populate array with files that will possibly fail one of the audits
   while read -r l_mpname; do
      while IFS= read -r -d $'\0' l_file; do
         [ -e "$l_file" ] && a_arr+=("$(stat -Lc '%n^%#a' "$l_file")")
      done < <(find "$l_mpname" -xdev -not -path "/run/user/*"  -type f \( -perm -2000 -o -perm -4000 \) -print0)
   done <<< "$(findmnt -Derno target)"
   # Test files in the array
   while IFS="^" read -r l_fname l_mode; do
      if [ -f "$l_fname" ]; then
         l_suid_mask="04000"; l_sgid_mask="02000"
         [ $(( $l_mode & $l_suid_mask )) -gt 0 ] && a_suid+=("$l_fname")
         [ $(( $l_mode & $l_sgid_mask )) -gt 0 ] && a_sgid+=("$l_fname")
      fi
   done <<< "$(printf '%s\n' "${a_arr[@]}")"
   if ! (( ${#a_suid[@]} > 0 )); then
      l_output="$l_output\n - There are no SUID files exist on the system"
   else
      l_output2="$l_output2\n - List of \"$(printf '%s' "${#a_suid[@]}")\" SUID executable files:\n$(printf '%s\n' "${a_suid[@]}")\n - end of list -\n"
   fi
   if ! (( ${#a_sgid[@]} > 0 )); then
      l_output="$l_output\n - There are no SGID files exist on the system"
   else
      l_output2="$l_output2\n - List of \"$(printf '%s' "${#a_sgid[@]}")\" SGID executable files:\n$(printf '%s\n' "${a_sgid[@]}")\n - end of list -\n"
   fi
   [ -n "$l_output2" ] && l_output2="$l_output2\n- Review the preceding list(s) of SUID and/or SGID files to\n- ensure that no rogue programs have been introduced onto the system.\n"
   unset a_arr; unset a_suid; unset a_sgid # Remove arrays
   # If l_output2 is empty, Nothing to report
   if [ -z "$l_output2" ]; then
      echo -e "\n- Audit Result:\n$l_output\n"
   else
      echo -e "\n- Audit Result:\n$l_output2\n"
      [ -n "$l_output" ] && echo -e "$l_output\n"
   fi
}
echo '==|==' 
/usr/bin/awk -F: '($2 == "") { print $1 " is not set to shadowed passwords"}' /etc/passwd | /usr/bin/awk '{print} END {if (NR == 0) print "Pass"'}
echo '==|==' 
/usr/bin/awk -F: '($2 == "") { print $1 " does not have a password"}' /etc/shadow | /usr/bin/awk '{print} END {if (NR == 0) print "Pass"'}
echo '==|==' 
#!/bin/bash
  {
for i in $(cut -s -d: -f4 /etc/passwd | sort -u ); do
  grep -q -P "^.*?:[^:]*:$i:" /etc/group
  if [ $? -ne 0 ]; then
    echo "Group $i is referenced by /etc/passwd but does not exist in /etc/group"
  fi
done } | /usr/bin/awk '{print} END {if (NR == 0) print "Pass" ; else print "Fail"}'
echo '==|==' 
#!/bin/bash
{
cut -f3 -d":" /etc/passwd | sort -n | uniq -c | while read x ; do
  [ -z "$x" ] && break
  set - $x
  if [ $1 -gt 1 ]; then
    users=$(awk -F: '($3 == n) { print $1 }' n=$2 /etc/passwd | xargs)
    echo "Duplicate UID ($2): $users"
  fi
done
} | /usr/bin/awk '{print} END {if (NR == 0) print "Pass" ; else print "Fail"}'
echo '==|==' 
#!/bin/bash
{
cut -d: -f3 /etc/group | sort | uniq -d | while read x ; do
    echo "Duplicate GID ($x) in /etc/group"
done } | /usr/bin/awk '{print} END {if (NR == 0) print "Pass" ; else print "Fail"}'
echo '==|==' 
#!/bin/bash
{
RPCV="$(sudo -Hiu root env | grep '^PATH' | cut -d= -f2)"
echo "$RPCV" | grep -q "::" && echo "root's path contains a empty directory (::)"
echo "$RPCV" | grep -q ":$" && echo "root's path contains a trailing (:)"
for x in $(echo "$RPCV" | tr ":" " "); do
   if [ -d "$x" ]; then
      ls -ldH "$x" | awk '$9 == "." {print "PATH contains current working directory (.)"}
      $3 != "root" {print $9, "is not owned by root"}
      substr($1,6,1) != "-" {print $9, "is group writable"}
      substr($1,9,1) != "-" {print $9, "is world writable"}'
   else
      echo "$x is not a directory"
   fi
done | /usr/bin/awk '{print} END {if (NR == 0) print "Pass" ; else print "Fail"}'
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_heout2="" l_hoout2="" l_haout2=""
   l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$"
   unset a_uarr && a_uarr=() # Clear and initialize array
   while read -r l_epu l_eph; do # Populate array with users and user home location
      a_uarr+=("$l_epu $l_eph")
   done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)"
   l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding
   [ "$l_asize " -gt "10000" ] && echo -e "\n  ** INFO **\n  - \"$l_asize\" Local interactive users found on the system\n  - This may be a long running check\n"
   while read -r l_user l_home; do
      if [ -d "$l_home" ]; then
         l_mask='0027'
         l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )"
         while read -r l_own l_mode; do
            [ "$l_user" != "$l_own" ] && l_hoout2="$l_hoout2\n  - User: \"$l_user\" Home \"$l_home\" is owned by: \"$l_own\""
            if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
               l_haout2="$l_haout2\n  - User: \"$l_user\" Home \"$l_home\" is mode: \"$l_mode\" should be mode: \"$l_max\" or more restrictive"
            fi
         done <<< "$(stat -Lc '%U %#a' "$l_home")"
      else
         l_heout2="$l_heout2\n  - User: \"$l_user\" Home \"$l_home\" Doesn't exist"
      fi
   done <<< "$(printf '%s\n' "${a_uarr[@]}")"
   [ -z "$l_heout2" ] && l_output="$l_output\n   - home directories exist" || l_output2="$l_output2$l_heout2"
   [ -z "$l_hoout2" ] && l_output="$l_output\n   - own their home directory" || l_output2="$l_output2$l_hoout2"
   [ -z "$l_haout2" ] && l_output="$l_output\n   - home directories are mode: \"$l_max\" or more restrictive" || l_output2="$l_output2$l_haout2"
   [ -n "$l_output" ] && l_output="  - All local interactive users:$l_output"
   if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
      echo -e "\n- Audit Result:\n  ** PASS **\n - * Correctly configured * :\n$l_output"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2"
      [ -n "$l_output" ] && echo -e "\n- * Correctly configured * :\n$l_output"
   fi
}
echo '==|==' 
#!/bin/bash
{
   l_output="" l_output2="" l_output3="" l_output4=""
   l_bf="" l_df="" l_nf="" l_hf=""
   l_valid_shells="^($( awk -F\/ '$NF != "nologin" {print}' /etc/shells | sed -rn '/^\//{s,/,\\\\/,g;p}' | paste -s -d '|' - ))$"
   unset a_uarr && a_uarr=() # Clear and initialize array
   while read -r l_epu l_eph; do # Populate array with users and user home location
      [[ -n "$l_epu" && -n "$l_eph" ]] && a_uarr+=("$l_epu $l_eph")
   done <<< "$(awk -v pat="$l_valid_shells" -F: '$(NF) ~ pat { print $1 " " $(NF-1) }' /etc/passwd)"
   l_asize="${#a_uarr[@]}" # Here if we want to look at number of users before proceeding
   l_maxsize="1000" # Maximun number of local interactive users before warning (Default 1,000)
   [ "$l_asize " -gt "$l_maxsize" ] && echo -e "\n  ** INFO **\n  - \"$l_asize\" Local interactive users found on the system\n  - This may be a long running check\n"
   file_access_chk()
   {
      l_facout2=""
      l_max="$( printf '%o' $(( 0777 & ~$l_mask)) )"
      if [ $(( $l_mode & $l_mask )) -gt 0 ]; then
         l_facout2="$l_facout2\n  - File: \"$l_hdfile\" is mode: \"$l_mode\" and should be mode: \"$l_max\" or more restrictive"
      fi
      if [[ ! "$l_owner" =~ ($l_user) ]]; then
         l_facout2="$l_facout2\n  - File: \"$l_hdfile\" owned by: \"$l_owner\" and should be owned by \"${l_user//|/ or }\""
      fi
      if [[ ! "$l_gowner" =~ ($l_group) ]]; then
         l_facout2="$l_facout2\n  - File: \"$l_hdfile\" group owned by: \"$l_gowner\" and should be group owned by \"${l_group//|/ or }\""
      fi
   }
   while read -r l_user l_home; do
      l_fe="" l_nout2="" l_nout3="" l_dfout2="" l_hdout2="" l_bhout2=""
      if [ -d "$l_home" ]; then
         l_group="$(id -gn "$l_user" | xargs)"
         l_group="${l_group// /|}"
         while IFS= read -r -d $'\0' l_hdfile; do
            while read -r l_mode l_owner l_gowner; do
               case "$(basename "$l_hdfile")" in
                  .forward | .rhost )
                     l_fe="Y" && l_bf="Y"
                     l_dfout2="$l_dfout2\n  - File: \"$l_hdfile\" exists" ;;
                  .netrc )
                     l_mask='0177'
                     file_access_chk
                     if [ -n "$l_facout2" ]; then
                        l_fe="Y" && l_nf="Y"
                        l_nout2="$l_facout2"
                     else
                        l_nout3="   - File: \"$l_hdfile\" exists"
                     fi ;;
                  .bash_history )
                     l_mask='0177'
                     file_access_chk
                     if [ -n "$l_facout2" ]; then
                        l_fe="Y" && l_hf="Y"
                        l_bhout2="$l_facout2"
                     fi ;;
                  * )
                     l_mask='0133'
                     file_access_chk
                     if [ -n "$l_facout2" ]; then
                        l_fe="Y" && l_df="Y"
                        l_hdout2="$l_facout2"
                     fi ;;
                  esac
            done <<< "$(stat -Lc '%#a %U %G' "$l_hdfile")"
         done < <(find "$l_home" -xdev -type f -name '.*' -print0)
      fi
      if [ "$l_fe" = "Y" ]; then
         l_output2="$l_output2\n - User: \"$l_user\" Home Directory: \"$l_home\""
         [ -n "$l_dfout2" ] && l_output2="$l_output2$l_dfout2"
         [ -n "$l_nout2" ] && l_output2="$l_output2$l_nout2"
         [ -n "$l_bhout2" ] && l_output2="$l_output2$l_bhout2"
         [ -n "$l_hdout2" ] && l_output2="$l_output2$l_hdout2"
      fi
      [ -n "$l_nout3" ] && l_output3="$l_output3\n  - User: \"$l_user\" Home Directory: \"$l_home\"\n$l_nout3"
   done <<< "$(printf '%s\n' "${a_uarr[@]}")"
   unset a_uarr # Remove array
   [ -n "$l_output3" ] && l_output3=" - ** Warning **\n - \".netrc\" files should be removed unless deemed necessary\n   and in accordance with local site policy:$l_output3"
   [ -z "$l_bf" ] && l_output="$l_output\n   - \".forward\" or \".rhost\" files"
   [ -z "$l_nf" ] && l_output="$l_output\n   - \".netrc\" files with incorrect access configured"
   [ -z "$l_hf" ] && l_output="$l_output\n   - \".bash_history\" files with incorrect access configured"
   [ -z "$l_df" ] && l_output="$l_output\n   - \"dot\" files with incorrect access configured"
   [ -n "$l_output" ] && l_output="  - No local interactive users home directories contain:$l_output"
   echo -e "$l_output4"
   if [ -z "$l_output2" ]; then # If l_output2 is empty, we pass
      echo -e "\n- Audit Result:\n  ** PASS **\n - * Correctly configured * :\n$l_output\n"
      echo -e "$l_output3\n"
   else
      echo -e "\n- Audit Result:\n  ** FAIL **\n - * Reasons for audit failure * :\n$l_output2\n"
      echo -e "$l_output3\n"
      [ -n "$l_output" ] && echo -e "- * Correctly configured * :\n$l_output\n"
   fi
}
echo "==|==" 
grep -nE "(\\[mrsv]|[Dd]ebian)" /etc/motd
echo "==|==" 
grep -nE "(\\[mrsv]|[Dd]ebian)" /etc/issue
echo "==|==" 
grep -nE "(\\[mrsv]|[Dd]ebian)" /etc/issue.net
echo "==|==" 
grep -nE "^[\s]*Enable[\s]*=[\s]*true" /etc/gdm3/custom.conf
echo "==|==" 
grep -nE "^[^#].*\!authenticate" /etc/sudoers /etc/sudoers.d/*
echo '==|==' 
stat -c %a /boot/grub/grub.cfg
echo '==|==' 
stat -c %a /etc/motd
echo '==|==' 
stat -c %a /etc/issue
echo '==|==' 
stat -c %a /etc/issue.net
echo '==|==' 
stat -c %a /etc/crontab
echo '==|==' 
stat -c %a /etc/cron.hourly
echo '==|==' 
stat -c %a /etc/cron.daily
echo '==|==' 
stat -c %a /etc/cron.weekly
echo '==|==' 
stat -c %a /etc/cron.monthly
echo '==|==' 
stat -c %a /etc/cron.d
echo '==|==' 
stat -c %a /etc/ssh/sshd_config
echo '==|==' 
stat -c %a /etc/passwd
echo '==|==' 
stat -c %a /etc/passwd-
echo '==|==' 
stat -c %a /etc/group
echo '==|==' 
stat -c %a /etc/group-
echo '==|==' 
stat -c %a /etc/shadow
echo '==|==' 
stat -c %a /etc/shadow-
echo '==|==' 
stat -c %a /etc/gshadow
echo '==|==' 
stat -c %a /etc/gshadow-
echo '==|==' 
stat -c %a /etc/shells
echo "==|==" 
grep -nE "^[\s]*set[\s]*superusers[\s]*=" /boot/grub/grub.cfg
echo "==|==" 
grep -nE "^[\s]*password" /boot/grub/grub.cfg
echo "==|==" 
grep -nE "^[\h]*pool[\h]+[\H]+" /etc/chrony/*.sources /etc/chrony/*.conf
echo "==|==" 
grep -nE "^[\h]*server[\h]+[\H]+" /etc/chrony/*.sources /etc/chrony/*.conf
echo "==|==" 
grep -nE "^\h*(NTP|FallbackNTP)=\H+" /etc/systemd/timesyncd.conf
echo "==|==" 
grep -nE "^\h*restrict\h+((-4\h+)?|-6\h+)default" /etc/ntp.conf
echo "==|==" 
grep -nE "^[\h]*pool[\h]+[\H]+" /etc/ntp.conf
echo "==|==" 
grep -nE "^[\h]*server[\h]+[\H]+" /etc/ntp.conf
echo "==|==" 
grep -nE "^\h*Defaults\h+([^#\n\r]+,)?use_pty(,\h*\h+\h*)*\h*(#.*)?$" /etc/sudoers /etc/sudoers.d/*
echo "==|==" 
grep -nE "^\h*Defaults\h+([^#]+,\h*)?logfile\h*=\h*(\"|\')?\H+(\"|\')?(,\h*\H+\h*)*\h*(#.*)?$" /etc/sudoers /etc/sudoers.d/*
echo "==|==" 
grep -nE "^\h*Defaults\h+([^#]+,\h*)?timestamp_timeout" /etc/sudoers /etc/sudoers.d/*
echo "==|==" 
grep -nE "^\h*difok\h*=\h*" /etc/security/pwquality.conf
echo "==|==" 
grep -nE "^\h*dictcheck\h*=\h*" /etc/security/pwquality.conf
echo "==|==" 
grep -nE "^root:" /etc/passwd
echo "==|==" 
grep -nE "^\h*maxrepeat\h*=\h*" /etc/security/pwquality.conf
echo "==|==" 
grep -nE "^ *URL=|^ *ServerKeyFile=|^ *ServerCertificateFile=|^ *TrustedCertificateFile=" /etc/systemd/journal-upload.conf
echo "==|==" 
grep -nE "^[\s]*Compress[\s]*=" /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*
echo "==|==" 
grep -nE "^[\s]*Storage[\s]*=" /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*
echo "==|==" 
grep -nE "^[\s]*ForwardToSyslog[\s]*=" /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*
echo "==|==" 
grep -nE "^[\s]*(SystemMaxUse|SystemKeepFree|RuntimeMaxUse|RuntimeKeepFree|MaxFileSec)[\s]*=" /etc/systemd/journald.conf /etc/systemd/journald.conf.d/*
echo "==|==" 
grep -nE "^[\s]*ForwardToSyslog[\s]*=" /etc/systemd/journald.conf
echo "==|==" 
grep -nE "^[\s]*\$FileCreateMode" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*\*\.emerg" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*auth,authpriv\.\*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*mail\.\*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*mail\.info" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*mail\.warning" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*mail\.err" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*cron\.*" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*\*\.=warning;\*\.=err" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*\*\.crit" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*\*\.\*;mail\.none;news\.none" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*local0,local1" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*local2,local3" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*local4,local5" /etc/rsyslog.conf /etc/rsyslog.d/*.conf
echo "==|==" 
grep -nE "^[\s]*local6,local7" /etc/rsyslog.conf /etc/rsyslog.d/*.conf