# DataStructuresScripting
Script used for quicker grading of data scructures students' projects

## Setup
If you are not running on a mac or linux machine, figure it out with powershell or something. Windows is bad. Anyways:

For setup, you must edit the config files in configs/
a readme file with directions on how to edit them is in configs/configsREADME.txt
Follow those directions and then follow the below instructions.

You must give permissions to the script to be run. Do so by cloning the repo, and then while in the cloned repository's directory, type:
```
chmod +x src/gradingScript.sh
```
This makes the script executable.

### Dependencies:
Python and pip:
```
sudo apt-get install python3 pip
```
canvas api:
```
pip install canvasapi
```

## Execution of the script
Since the addition of the python scrips, there is no need for arguments sent to the script. The script will handle executable names on its own. Running the script only takes a single command:
```
python3 GradingProgram.py
```
## Timing Data
The addition of timing data for each of the projects has been added, allowing for timing data to be acquired. It is in a file named timings.txt. The data only takes into account full seconds. If more precise timing data is needed, then using linux's "time" in terminal is a better option for sub-second precision.
