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
