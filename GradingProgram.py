import subprocess

# Print welcome message
print("Welcome to the Grading Script for CS-2341 Developed by Christian Gould!")
print("Starting Now...")

# Run the git puller and cmake project runner
print("Starting the cmake project runner, will start by pulling from git")
subprocess.call('./src/gradingScript.sh')

# Run the grading assistant
# import src.canvasGrader

print("Grading Program Has Finished.")
