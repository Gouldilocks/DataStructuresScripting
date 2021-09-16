# DataStructuresScripting
Script used for quicker grading of data scructures students' projects

## Setup
In "GitRepos.txt", you need to put clone links to each of the student's repositories, separated by newlines. An example of this is in the repo

In "InputFilePaths.txt", you need to put the command line arguments that are to be sent to the program in the order they are to be sent, separating each by newline.

You must give permissions to the script to be run. Do so by cloning the repo, and then while in the cloned repository's directory, type:
```
chmod +x gradingScript.sh
```
This makes the script executable.

## Execution of the script
The script demands a single command line argument, that argument being the name of the executable. This should be the same for all students, assuming they do not extensively edit the CmakeLists.txt file. For example, the first project can be run with the sript like so:
```
./gradingScript.sh pa01_sentiment
```
If a student changes the executable, then you must run that program independently. Support for different executable names will come in the future.

