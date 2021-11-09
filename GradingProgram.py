import subprocess

try:
  # Get Constants
  constantsFile = open('./configs/constants.txt', 'r')
  constants = constantsFile.readlines()
  both = constants[1].split('=')
  ASSIGNMENT_TO_GRADE = both[1] #'PA 02' at time of writing
  both = constants[0].split('=')
  SEMESTER = both[1].strip('\n') #'21f' at time of writing
  print('constants received: '+ ASSIGNMENT_TO_GRADE + ',' + SEMESTER)
except Exception as e:
  print (e)
  print("Problem getting constants. Make sure all your config files are correct.")

# Print welcome message
print("Welcome to the Grading Script for CS-2341 Developed by Christian Gould!")
print("Starting Now...")

# Formulate the git repo links
print("Creating git repo clone links from config information...")

try:
  # Input all the students
  studentNames = []
  studentGithubs = []
  studentFile = open('./configs/studentNames.txt', 'r')
  for line in studentFile:
    line = line.rstrip('\n')
    line = line.rstrip('\t')
    both = line.split(',')
    studentNames.append(both[0])
    studentGithubs.append(both[1])
  print("grading these students: " + str(len(studentNames)))
  print("-----------------------")
  for i, x in zip(studentNames, studentGithubs):
    print(i + ", Github: " + x)
except:
  print("Problem getting students. Make sure all your config files are correct and try again.")

# Write to the github links file
START_OF_LINK = 'https://github.com/SMUCSE2341/' + SEMESTER.replace(' ', '').lower().rstrip('\n') + '-' + ASSIGNMENT_TO_GRADE.replace(' ','').lower().rstrip('\n') + '-'
START_OF_LINK = START_OF_LINK.rstrip('\n')
githubRepos = open('./dontTouchMe/GitRepos.txt', 'w')
for ghName in studentGithubs:
  print("DEBUGGING: ")
  print(START_OF_LINK)
  print(ghName.rstrip('\n'))
  githubRepos.write(START_OF_LINK + ghName + '.git')
  if(ghName != studentGithubs[-1]):
    githubRepos.write('\n')
githubRepos.close()

# Run the git puller and cmake project runner
print("Starting the cmake project runner, will start by pulling from git")
subprocess.call('./src/gradingScript.sh')

# Run the grading assistant
import src.canvasGrader

print("Grading Program Has Finished.")
