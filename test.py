import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='192.168.56.115', port=22,
            username='vboxuser', password='AskDNV8!')

# To execute a
# cmd = "/usr/bin/dpkg -s rsync | /bin/grep -E '(Status:|not installed)'"
cmd = "/usr/bin/dpkg -s nis 2>&1"
stdin, stdout, stderr = ssh.exec_command(cmd)
print(stdout.read().decode())
print(stderr.read().decode())
