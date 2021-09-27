#!/bin/bash

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
    echo "RUNNING: $PWD/$execname$args with easy dataset"
    echo "---------------------------------------------"
    start=$(date +%s)
    ./$execname$args
    end=$(date +%s)
    runtime=$(($end-$start))
    echo "Running hard args now"
    echo "---------------------------------------------"
    ./$execname$hardargs
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
