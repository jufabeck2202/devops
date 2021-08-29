# Linux 
## Searching
### Using Wildcards
Du -> Disk usage, check local disc usage
```
du -sh a*
```
### Find Command
Searching for files and directories named gcc:
```
find /usr -name gcc
```
Searching only for directories named gcc:
```
find /usr -type d -name gcc
```
Searching only for regular files named gcc:
```
find /usr -type f -name gcc
```
To find and remove all files that end with .swp:
```
find -name "*.swp" -exec rm {} ’;’
```
For example, to find files greater than 10 MB in size and running a command on those files:
```
find / -size +10M -exec command {} ’;’
```
## Documentation
### man
Find man pages that match this name.
```
man -a socket
```
### info
```
info
```
## Processes
- Interactive Processes
- Batch Processes, queued tasks
- Daemons, continuously running server processes
- Threads, lightweight processes sharing memory and other resources
- Kernel Threads, Kernel Tasks  

Each process has an *PID*.
Multi-threaded processes share the same *PID*, but have a unique *TID*
### ps command 
Display all processes running under the current shell
show processes and process parent id using `-f`
```
ps -f
```
Display all processes in full detail
```
ps -elf | less
```
ps aux displays all processes of all users.
```
ps aux
```
show process three
```
pstree
```
### nice value
the lower the nice value the higher the process priority. (-20 to +19)
change priority	
```
renice +5 <pid>
```
see niceness value
```
ps -l
```
### process load average
load average showing using 3 numbers: the last minute, last 5 minutes and last 15 miniutes of utilization

```
w
```

### Background and Foreground Processes
a job in the terminal can be run in the background by appending a `&` to the command

to display jobs running in the background use the `jobs` command
```
jobs -l
```
### Terminate
Kill a process
```
kill -SIGKILL <pid>
```
### Scheduling a Process
perform a task in the future using `at`. If no file is provided the command is interactive

```
at now + 1 minute -f bash.sh
```

using `cron` run a task at a specific time
```
30 08 10 06 * /home/sysadmin/full-backup
```
## File Operations
On multi-user systems the `/home`directory hold the user directory.

The `/bin`directory contains executable binaries. User binaries are located under `/usr/bin`.

Filesystems mounted at `/proc`, are called pseudo-filesystems because they have no permanent presence. They contain virtual files in memory. like cpuinfo, meminfo etc. 

The `/dev` directory contains device nodes, a type of pseudo-file used by most hardware and software devices, except for network devices.
- `/dev/random` random numbers
- `/dev/sda1/` first partition

The `/var` directory contains files that are expected to change in size and content as the system is running. 
- `/var/log`system log files
- `/var/tmp`temporary files
  
The `/etc` directory is the home for system configuration files.

The `/boot` directory contains the few essential files needed to boot the system.

The `/lib`directory contains libraries for essential programms. The filenames star with `ld` `lib`

Removable media is mounted at `run`. 
### Mounting
mount dhe device node to the mounting point
```
sudo mount /dev/sda5 /home
```
```
sudo umount /home
```
to mount something on startup use `fstab`

### Compare files with diff
Compare files and directories
```
diff [options] <filename1> <filename2>
```
To compare 3 files use `diff3`

Generate a Patch file
```
diff -Nur originalfile newfile > patchfile
```
Apply patch file to file
```
patch -p1 < patchfile
```
### Compress Data
Compress all files in directory using `gzip`
```
gzip -r projectX
```
Compress using `tar`
```
tar zcvf mydir.tar.gz mydir
```
## Users and Permissions

To identify the current user use `whoami` To list all logged in users use `who`, or `who -a `to see more information.
### Order of Startup Files
1. bashrc 
2. bash_profile
3. bash_login
4. profile

### Linux Users and Groups
All Linux users are assigned a unique user ID _(uid)_, which is just an integer; normal users start with a uid of 1000 or greater.
Users also have one or more group IDs (gid), including a default one which is the same as the user ID. These numbers are associated with names through the files /etc/passwd and /etc/group. Groups are used to establish a set of users who have common interests for the purposes of access rights, privileges, and security considerations. Access rights to files (and devices) are granted on the basis of the user and the group they belong to.

### Adding and Removing Users
Adding a new user 
```
sudo useradd beju
```
see user in `/home/beju`
```
beju:x:1002:1002::/home/beju:/bin/bash
```
Delete user
```
userdel beju
```
see information about the user using `id`

### Adding and Removing Groups
Adding a new group
``` 
sudo /usr/sbin/groupadd anewgroup
```
delete group
``` 
sudo /usr/sbin/groupdel anewgroup
```
See what group a user belongs to
```
groups beju
```
### Permissions

Use `chown` used to change user ownership of file or directory.
Files have three kinds of permissions: read (r), write (w), execute (x). These are generally represented as in rwx. These permissions affect three groups of owners: user/owner (u), group (g), and others (o).

Give the owners and others execution and remove group write
```
chmod uo+x,g-w somefile
```
- 4 if read permission is desired
- 2 if write permission is desired
- 1 if execute permission is desired.
> 7 means read/write/execute, 6 means read/write, and 5 means read/execute.

make file executable by doing
```
chmod 755 somefile
```
```
chmod +x file
```


- File permissions can be changed by typing chmod permissions filename.
- File ownership is changed by typing chown owner filename.
- File group ownership is changed by typing chgrp group filename.
### Root Account
Use `su` to launch a new shell using a root user

Execute previous command with sudo using `!! sudo`

## Environment Variable
Show value
```
echo $SHELL
```
Export a new variable
```
export BEJU=dsf
```

The `PATH`Variable is an ordered list of directories which is scanned when a command is given to find the programm or script.

Add Home Path to export
```
export PATH=$HOME/bin:$PATH
```

## Manipulating Text
### Cat
Clear and add files until `CTRL-D`
```
cat > file
```
Append to files until `CTRL-D`
```
cat >> file
```
cat until EOF
```
cat > <filename> << EOF
> something
> EOF
```
### echo
Clear and add text
```
echo beju > file
```
Append to text to file
```
cat beju >> file
```
### less
Pipe file into less to view page by page
```
cat somefile | less
```
### head
view 5 first lines
```
head -5 /etc/default/grub
```
### tail
view 5 last lines
```
tail -5 /etc/default/grub
```
To continually monitor new output in a growing log file:
```
$ tail -f somefile.log
```
### sed
used to modify the contents of a file or input stream, usually placing the contents into a new file or output stream

Use sed to filter standard input, putting output on standard out
```
sed s/pattern/replace_string/g file1 > file2
```
```
echo "I hate you" | sed s/hate/love/
```
Output to terminal using -e. Normally `sed` only replaces the first occurrence. To replace all use `\g`

### awk
awk is used to extract and then print specific contents of a file and is often used to construct reports. 
Print entire file
```
awk '{ print $0 }' /etc/passwd
```
Print first field (column) of every line, separated by a space
```
awk -F: '{ print $1 }' /etc/passwd
```
Print first and seventh field of every line
```
awk -F: '{ print $1 $7 }' /etc/passwd	
```
Sort the lines in the specified file, according to the characters at the beginning of each line
```
sort <filename>	
```
Combine the two files, then sort the lines and display the output on the terminal
```
cat file1 file2 | sort	
```
Sort the lines in reverse order
```
sort -r <filename>	
```
Sort the lines by the 3rd field on each line instead of the beginning
```
sort -k 3 <filename>	
```
### uniq
uniq removes duplicate consecutive lines in a text file and is useful for simplifying the text display.
```
sort file1 file2 | uniq > file3
```
count unique lines
```
uniq -c filename
```
### paste
paste can be used to combine fields (such as name or phone number) from different files, as well as combine lines from multiple files.
Go Line by line
To paste contents from two files one can do:
```
paste file1 file2
```
The syntax to use a different delimiter is as follows:
```
$ paste -d, file1 file2
```
Common delimiters are 'space', 'tab', '|', 'comma', etc.

### split
```
split inputfile dict_output
```

### count words
```
wc -l file
```
### grep
grep is extensively used as a primary text searching tool. It scans files for specified patterns and can be used with regular expressions, as well as simple strings, as shown in the table:
```
grep [pattern] <filename>	
```

### other
The tr utility is used to translate specified characters into other characters or to delete them.

```
tr '{}' '()' < inputfile > outputfile
```
Save to file AND display in terminal using tee
```
ls -l | tee newfile
```

## Networking
set nameserver at `/etc/resolv.conf`

information about a service using
```
host linuxfoundation.org
```