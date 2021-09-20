#!/bin/bash

# Get the arguments for the executables
    args=''
    echo "RETRIEVING ARGS FROM args.txt"
    # Pull from file line by line, adding onto args variable each iteration
    while IFS= read -r line; do
        args+=" $line"
        echo "Text read from file: $line"
    done < args.txt
    echo "args received are: $args"

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

# Run Cmake and Make on all projects, and then run them
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
    start=$(date +%s)
    ./$execname$args
    end=$(date +%s)
    runtime=$(($end-$start))

    # Print runtime to timings.txt
    echo "Runtime for: $project = $runtime seconds" >> ../../timings.txt

    # Change dir to outside of project directory
    cd ..
    done

    # Change dir out of projects/
    cd ..
