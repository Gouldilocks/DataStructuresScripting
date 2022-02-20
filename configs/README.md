All files in this folder are files which you must edit in order to run the program properly.

## apiKey.txt 
- You must put the api key for canvas in this text file.
- This file should NOT change from project to project.
- Just paste it in with nothing else in the text file, not even a new line.
- the key wil be a hashed key code of some sort.

## args.txt 
- These are the command line arguments that will be sent to each of the programs.
- Each of the arguments you would like to send should be in-order, and separated by newlines.

## desiredOutput.txt: Only Required if you are using canvasGrader.py
- This file should contian the output which a perfect-run of the program would
  ideally produce. It will be compared to the students' outputs via a percentage.

## studentNames.txt: Only Required if you are using canvasGrader.py
- This file should contain the names of the students.
- The names are in whatever order you desire, and separated by newlines.

## constants.txt: Only Required if you are using canvasGrader.py
- This file should contain the constants that will be used in the program.
- Semester: The semester you are grading for (e.g. 22s)
- Assignment: The assignment you are grading for (e.g. "PA 01")

Do not edit any of the files in the directory dontTouchMe/. They are used by the program for data transfer between scripts