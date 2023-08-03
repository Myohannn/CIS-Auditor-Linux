import paramiko
import time

ssh = paramiko.SSHClient()
ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
ssh.connect(hostname='192.168.56.115', port=22,
            username='vboxuser', password='AskDNV8!')

# To upload a file
localpath = 'out\script\CIS_Debian_Linux_10_v2.0.0_L1_Server.sh'
remotepath = '/tmp/test_kali.sh'
sftp = ssh.open_sftp()
sftp.put(localpath=localpath, remotepath=remotepath)
sftp.close()

# To make the script executable
cmd = 'chmod +x ' + remotepath
ssh.exec_command(cmd)

cmd = "sed -i -e 's/\r$//' " + remotepath
ssh.exec_command(cmd)

# Start an interactive shell session
shell = ssh.invoke_shell()

# # Make the script executable
# cmd = 'chmod +x ' + remotepath + '\n'
# shell.send(cmd)
# time.sleep(1)

# cmd = "sed -i -e 's/\r$//' " + remotepath + '\n'
# shell.send(cmd)
# time.sleep(1)

# Switch to the root user
shell.send('su -\n')
time.sleep(1)

# Send the root password
shell.send('AskDNV8!\n')
time.sleep(1)
print("Logged in to su")

# Execute the script and print a finish marker at the end
cmd = remotepath + ' > /tmp/output.txt 2>&1;\n'
shell.send(cmd)
time.sleep(40)

# # # Read from stdout until the finish marker is found
# while not shell.recv_ready():  # Wait until there is output to read
#     time.sleep(1)

# output = ''
# while not 'Script finished' in output:
#     output += shell.recv(1024).decode('utf-8')
#     print(output)

# Exit su and close the shell session
shell.send('exit\n')
shell.close()

# Download the output file
sftp = ssh.open_sftp()
sftp.get(remotepath='/tmp/output.txt', localpath='output_Debian11_su.txt')
sftp.close()
print("File downloaded")

# Remove the script and the output file
stdin, stdout, stderr = ssh.exec_command(
    'rm /tmp/test_kali.sh /tmp/output.txt')
print("remote file removed")

stdin.close()
