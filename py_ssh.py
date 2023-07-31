import paramiko

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='192.168.56.104', port=22,
            username='kali', password='AskDNV8!')

# # To execute a command
# stdin, stdout, stderr = ssh.exec_command('ls')
# print(stdout.read().decode())

# To upload a file
localpath = 'out\script\CIS_Debian_Linux_10_v1.0.0_L1_Server.sh'
remotepath = '/tmp/test_kali.sh'
sftp = ssh.open_sftp()
sftp.put(localpath=localpath, remotepath=remotepath)
sftp.close()

# To make the script executable
cmd = 'chmod +x ' + remotepath
ssh.exec_command(cmd)

cmd = "sed -i -e 's/\r$//' " + remotepath
ssh.exec_command(cmd)

# To execute the script
cmd = remotepath + ' > /tmp/output.txt'
stdin, stdout, stderr = ssh.exec_command(cmd)
print(stdout.read().decode())

sftp = ssh.open_sftp()
sftp.get(remotepath='/tmp/output.txt', localpath='output_num.txt')
sftp.close()

# To make the script executable
# cmd = 'rm /tmp/test_kali.sh /tmp/output.txt'
# ssh.exec_command(cmd)

ssh.close()
