# import paramiko

# ssh = paramiko.SSHClient()
# ssh.set_missing_host_key_policy(paramiko.AutoAddPolicy())
# ssh.connect(hostname='192.168.56.115', port=22,
#             username='vboxuser', password='AskDNV8!')

# # To execute a
# # cmd = "/usr/bin/dpkg -s rsync | /bin/grep -E '(Status:|not installed)'"
# cmd = "/usr/bin/dpkg -s nis 2>&1"
# stdin, stdout, stderr = ssh.exec_command(cmd)
# print(stdout.read().decode())
# print(stderr.read().decode())


file_permission = '-rwxrwx---'

file_permission_char = ''
file_permission_int = 0
for i in range(1, len(file_permission)):

    if file_permission[i] == 'r':
        file_permission_int += 4
    elif file_permission[i] == 'w':
        file_permission_int += 2
    elif file_permission[i] == 'x':
        file_permission_int += 1
    else:
        file_permission_int += 0

    if i % 3 == 0:
        file_permission_char += str(file_permission_int)
        file_permission_int = 0

file_mask = ''
for i in file_permission_char:
    file_mask += str(7-int(i))

print(file_mask)
