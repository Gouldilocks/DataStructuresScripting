#!/bin/bash
# Get the arguments for the executables
args=''
echo "RETRIEVING ARGS FROM InputFilesPaths.txt"
while IFS= read -r line; do
    args+=" $line"
    echo "Text read from file: $line"
done < InputFilePaths.txt
#args includes a space at the beginning, so when passed as args to executable, no need to add a space then.
echo "args received are: $args"

# Clone all projects from the students
sudo rm -r projects
mkdir projects
cd projects
while IFS= read -r line; do
	echo "Cloning: $line"
	git clone $line
done < ../GitRepos.txt
cd ..

# Run Cmake and Make on all projects, and then run them
cd projects
for project in *; do
echo "Project name: $project"
cd $project
cmake .
make
start=$(date +%s)
workDire=$PWD
workDire+="/CMakeLists.txt"
echo "path sent to python is: $workDire"
python3 ../../main.py "$workDire"
execname="$(head -1 ../../executableName.txt)"
echo "found executable name: $execname"
echo "RUNNING: $PWD/$execname$args"
./$execname$args
end=$(date +%s)
runtime=$(($end-$start))
echo "Runtime for: $project = $runtime seconds" >> ../../timings.txt
cd ..
done
cd ..
