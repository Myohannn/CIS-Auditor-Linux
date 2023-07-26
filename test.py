import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='192.168.56.104', port=22,
            username='kali', password='')

# To execute a 
cmd ='''/usr/bin/dpkg -l xserver-xorg*'''
stdin, stdout, stderr = ssh.exec_command(cmd)
print(stdout.read().decode())