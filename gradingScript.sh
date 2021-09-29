#!/bin/bash

# Check for dependencies and install if not found
	# Check for Valgrind
	if ! command -v <valgrind> &> /dev/null
	then
		# Install if not found
		sudo apt-get -y install valgrind
	fi
	# Check for Git
	if ! command -v <git> &> /dev/null
	then
		# Install if not found
		sudo apt-get -y install git
	fi
	# Check for Cmake
	if ! command -v <cmake> &> /dev/null
	then
		# Install if not found
		sudo apt-get -y install cmake
	fi


# Get the arguments for the executables
    args=''
    echo "RETRIEVING ARGS FROM args.txt"
    # Pull from file line by line, adding onto args variable each iteration
    while IFS= read -r line; do
        args+=" $line"
        echo "Text read from file: $line"
    done < args.txt
    echo "easy Args received are: $args"
    
    hardargs=''
    echo "RETRIEVING ARGS FROM hardArgs.txt"
    # Pull from file line by line, adding onto hardargs variable each iteration
    while IFS= read -r line; do
        hardargs+=" $line"
        echo "Text read from file: $line"
    done < hardArgs.txt
    echo "easy Args received are: $hardargs"
    

# Clone all projects from the students
    # Remove projects folder if it exists, then replace it
    sudo rm -r projects
    mkdir projects
    cd projects
    # Pulls from file line by line, then clones the repo pulled from the file
    while IFS= read -r line; do
        echo "Cloning: $line"
        git clone $line
    done < ../GitRepos.txt
    cd ..

# Run Cmake and Make on all projects, and then run them with both easy and hard args
    cd projects
    for project in *; do
    echo "Project name: $project"

    # Change directory into project directory, run cmake and make on the project
    cd $project
    cmake .
    make

    # Parse the cmakelists for the executable name
    workDire=$PWD
    workDire+="/CMakeLists.txt"
    echo "path sent to python is: $workDire"
    python3 ../../cmakeListsParser.py "$workDire"
    execname="$(head -1 ../../executableName.txt)"
    echo "found executable name: $execname"

    # Run the executable found with and without arguments, using start and end for timing info
    echo "RUNNING: $PWD/$execname$args"
    echo "---------------------------------------------" 
    echo "Running with easy dataset"
    echo "---------------------------------------------"
    start=$(date +%s)
    timeout 5s ./$execname$args
    end=$(date +%s)
    runtime=$(($end-$start))
    echo "---------------------------------------------"
    echo "Running hard args now"
    echo "---------------------------------------------"
    timeout 5s ./$execname$hardargs
    echo "---------------------------------------------"
    echo "Running Catch now"
    echo "---------------------------------------------"
    ./$execname

    # Print runtime to timings.txt
    echo "Runtime for: $project = $runtime seconds" >> ../../timings.txt

    # Change dir to outside of project directory
    cd ..
    done

    # Change dir out of projects/
    cd ..
