*If you are only running the programs, you must only edit 2 files

## GitRepos.txt
- This file should contain all the .git http links to all of the github repositories of all your students
- separate each link with a newline
- One quirk of shell scripting is that you must add a newline after your last line you would like to read in or it will miss the last one, so do that.

## args.txt 
- These are the command line arguments that will be sent to each of the programs.
- Each of the arguments you would like to send should be in-order, and separated by newlines.
- Same thing as above with the newline stipulation

# Required Files for canvasGrader.py

## apiKey.txt 
- You must put the api key for canvas in this text file.
- This file should NOT change from project to project.
- Just paste it in with nothing else in the text file, not even a new line.
- the key wil be a hashed key code of some sort.

## desiredOutput.txt
- This file should contian the output which a perfect-run of the program would
  ideally produce. It will be compared to the students' outputs via a percentage.

## studentNames.txt
- This file should contain the names of the students.
- The names are in whatever order you desire, and separated by newlines.

## constants.txt
- This file should contain the constants that will be used in the program.
- Semester: The semester you are grading for (e.g. 22s)
- Assignment: The assignment you are grading for (e.g. "PA 01")

Do not edit any of the files in the directory dontTouchMe/. They are used by the program for data transfer between scripts
