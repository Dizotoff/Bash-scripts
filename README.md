# Bash-script from the System administration and maintenance course at Mount Royal University, Canada

## Here is the task: 
For most developers creating a common structure for their projects helps keep things organized.
That way they (and everyone they work with) have common places for common types of files.
Your will create a group of scripts and bash functions that will create a project structure for a
user.
In it's normal operation your script will take a project name and create a new directory for that
project. It will then consult a file called /etc/scriptbuilder/default/structure, which will contain (one
on each line) a list of sub-directories. Your script should then create each of the subdirectories
in the file in the project directory.
Your script should then check a directory called /etc/scriptbuilder/default/contents which will hold
some directories, if a directory in the contents directory matches one in the project directory the
files in the contents directory should be copied to the project directory (so, if
/etc/scriptbuilder/default/contents/docs and <project>/docs both exist, the contents of
/etc/scriptbuilder/default/contents/docs should be copied).
Your script should accept a flag -s <file> which changes the source file for the directory and
replaces /etc/scriptbuilder/default/structure with <file>. Your script should also accept a flag -d
<directory> which changes the directory which gets checked for default contents.
Your script should should also accept a -c flag which compares the argument directory to the
sources (either the defaults or the versions set by -d or -s). When running in this mode the script
should not create directories and files, but instead should print a report of any files from the
sources that are missing.
Your script should also accept a -p <file> flag which will preserve the structure of a directory.
Instead of consulting a file and creating a project structure, it will consult a project structure and
record each of the subdirectories in the project directory in the given file.
Your script should accept a -v flag. In verbose mode, your script should print all of the actions it
is taking while it takes them. Otherwise it should only print any needed error messages.
Finally your script should accept a flag, -x, which will make it behave in debug mode. In this
mode instead of creating the subdirectories and copying the contents, will print out all of the
changes the script would make without actually making them.
Your script should fail if it's given a directory that already exists, or one that that the user doesn't
have permission to create a directory in. It should fail if the script or any of the flags are not
given a value. If your script fails it should print a meaningful error message.
