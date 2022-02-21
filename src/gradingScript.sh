#!/bin/bash

# Check for dependencies and install if not found
	# Check for Valgrind
	valgrind="available"
	available="available"
	if ! [ -x "$(command -v valgrind)" ];
	then # Notify user that valgrind is not installed
	    echo "---------------------------------------------"
	    echo "Valgrind is not installed, not running valgrind commands"
	    echo "To install on linux, use the command: sudo apt-get install valgrind"
	    echo "---------------------------------------------"
	    valgrind="notavailable"
    	fi
	# Check for Git
	if ! [ -x "$(command -v git)" ];
	then
		# Install if not found
		apt-get -y install git
	fi
	# Check for Cmake
	if ! [ -x "$(command -v cmake)" ];
	then
		# Install if not found
        echo "installing cmake for you, why do you not have this??"
	  apt-get -y install cmake
	fi


# Get the arguments for the executables
    args=''
    echo "RETRIEVING ARGS FROM args.txt"
    # Pull from file line by line, adding onto args variable each iteration
    while IFS= read -r line; do
        args+=" $line"
    done < ./configs/args.txt
    echo "easy Args received are: $args"    

# Clone all projects from the students
    # Remove projects folder if it exists, then replace it
    rm -r projects
    mkdir projects
    cd projects
    # Pulls from file line by line, then clones the repo pulled from the file
    while IFS= read -r line; do
        echo "Cloning: $line"
        git clone $line
    done < ../configs/GitRepos.txt
    cd ..

# Run Cmake and Make on all projects, and then run them with both easy and hard args
    
    for project in projects/*; do
    echo "Project name: $project"

    # Change directory into project directory, run cmake and make on the project
    cd $project
    cmake .
    make
    cd ../..

    # Parse the cmakelists for the executable name
    workDire=$PWD
    workDire+="/$project/CMakeLists.txt"
    echo "path sent to python is: $workDire"
    python3 ./src/cmakeListsParser.py "$workDire"
    execname="$(head -1 ./dontTouchMe/executableName.txt)"
    echo "found executable name: $execname"
    outfileName=" $PWD/$project/gradingFile.txt"
    echo "output: $outfileName"

    # Run the executable found with and without arguments, using start and end for timing info
    echo "RUNNING: $PWD/$project/$execname$args$outfileName"
    echo "---------------------------------------------" 
    echo "Running with dataset"
    echo "---------------------------------------------"
    start=$(date +%s)
    timeout 5s $PWD/$project/$execname$args$outfileName
    end=$(date +%s)
    runtime=$(($end-$start))
    echo "---------------------------------------------"
    echo "Running Catch now"
    echo "---------------------------------------------"
    $PWD/$project/$execname
    if [ "$valgrind" == "$available" ]; then
    echo "---------------------------------------------"
    echo "Running Valgrind now"
    echo "---------------------------------------------"
    timeout 5s valgrind --leak-check=full --show-leak-kinds=all --track-origins=yes --verbose --log-file=valgrindEasyArgs.txt $PWD/$project/$execname$args$outfileName
    fi
    # Print runtime to timingData.txt
    echo "Runtime for: $project = $runtime seconds" >> ../timingData.txt

    # Change dir to outside of project directory
    done
