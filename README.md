# DataStructuresScripting
Script used for quicker grading of data scructures students' projects

## Setup
If you are not running on a mac or linux machine, figure it out with powershell or something. Windows is bad. Anyways:

In "GitRepos.txt", you need to put clone links to each of the student's repositories, separated by newlines. An example of this format is in the repo

In "InputFilePaths.txt", you need to put the command line arguments that are to be sent to the program in the order they are to be sent, separating each by newline. An example of this is in the repo

You must give permissions to the script to be run. Do so by cloning the repo, and then while in the cloned repository's directory, type:
```
chmod +x gradingScript.sh
```
This makes the script executable.

## Execution of the script
Since the addition of the main.py file, there is no need for arguments sent to the script. The script will handle executable names on its own. Running the script only takes a single command:
```
./gradingScript.sh
```
