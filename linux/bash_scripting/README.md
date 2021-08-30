# Bash Scripting
## Basics
### Read from prompt
```sh
#!/bin/bash
read name
# Display variable input
echo Hello :$name
```
### Return Value 
The return of the last script execution can be viewed using `$`
Where `0` indicates success. 

### Multiple Commands Single line
execute all
```sh
make ; make install ; make clean
```
abort if one failes
```sh
make && make install && make clean
```
proceed until something succeeds and then you stop executing any further steps.
```sh
cat file1 || cat file2 || cat file3
```
### Script Parameters
Get number of parameters using `$#`

### Command Substitution
insert output
```sh
ls /lib/modules/$(uname -r)/
```
### Variables
no prefix is required for setting or modifying a variable
```sh
MYVAR=beju
```
These variables however are only accessible inside the script.
To promote the var to an environment var use
```sh
export VAR=value
```
### Functions
Using Functions
```sh
display () {
   echo $1
}
display beju
display sito
```
### if statement
```sh
if condition
then
       statements
else
       statements
fi
```
#### check if file exists
Checks if the file is a regular file (i.e. not a symbolic link, device node, directory, etc.)
```
if [ -f "$1" ]
```
#### check if executable
```
if [ -x /etc/passwd ]
```
#### check if directory
```
if [ -d /etc/passwd ]
```
### Strings
Compares the sorting order of string1 and string2.
```
[[ string1 > string2 ]]	
```
Compares the characters in string1 with the characters in string2.
```sh
[[ string1 == string2 ]]	
```
Saves the length of string1 in the variable myLen1.
```
myLen1=${#string1}
```
### case
```sh
case expression in
   pattern1) execute commands;;
   pattern2) execute commands;;
   pattern3) execute commands;;
   pattern4) execute commands;;
   * )       execute some default commands or nothing ;;
esac
```
### loops
#### for loops
```sh
for j in list
do
    echo $j
done

```
#### while
```sh
while condition is true
do
    Commands for execution
    ----
done
```
#### until
```sh 
until condition is false
do
    Commands for execution
    ----
done

```
### create temp file
```sh
TEMP=$(mktemp /tmp/tempfile.XXXXXXXX)
```