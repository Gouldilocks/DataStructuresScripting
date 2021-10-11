from canvasapi import Canvas
from difflib import SequenceMatcher
from difflib import Differ
from pprint import pprint

# Get Constants
constantsFile = open('./configs/constants.txt', 'r')
constants = constantsFile.readlines()
both = constants[1].split('=')
ASSIGNMENT_TO_GRADE = both[1] #'PA 02' at time of writing
both = constants[0].split('=')
SEMESTER = both[1].strip('\n') #'21f' at time of writing
print('constants received: '+ ASSIGNMENT_TO_GRADE + ',' + SEMESTER)

# Set the canvas url and key
API_URL = 'https://smu.instructure.com/'
keyfile = open('./configs/apiKey.txt', 'r')
API_KEY = keyfile.readline()

def getValgrindBlocks(ghUser):
  valgrindLines = []
  path = './projects/' + SEMESTER + "-" + ASSIGNMENT_TO_GRADE.replace(" ", "").lower() + "-" + ghUser + "/valgrindEasyArgs.txt"
  print(path)
  valgrindFile = open(path, "r")
  lines = valgrindFile.readlines()
  for line in lines:
    line.rstrip('\n')
    if line.find("lost:") != -1:
      valgrindLines.append(line)
  return valgrindLines

# Get the output File name
outFile = 'couldn\'tFindFile'
argsFile = open('./configs/args.txt', 'r')
argsLines = argsFile.readlines()
for line in argsLines:
  line.replace('\n', '')
  if line.find('/') == -1:
    outFile = line

# Initialize a new Canvas object
canvas = Canvas(API_URL, API_KEY)
account = canvas.get_current_user()

# Input all the students and then print it out to the user
studentNames = []
studentGithubs = []
studentFile = open('./configs/studentNames.txt', 'r')
for line in studentFile:
  line = line.rstrip('\n')
  both = line.split(',')
  studentNames.append(both[0])
  studentGithubs.append(both[1])
print("grading these students: " + str(len(studentNames)))
print("-----------------------")
for i, x in zip(studentNames, studentGithubs):
  print(i + ", Github: " + x)

# List all courses. Use this to find out the course number to put below.
# courses = canvas.get_courses()
# for course in courses:
#   print(course)

# Get the course
course = canvas.get_course(88262)

# Get the students using their names and put the user objects into students list
students = []
for studentName in studentNames:
  student = course.get_users(search_term=studentName)
  for s in student:
   students.append(s)

# Print the students received from canvas for user to confirm
print("\nprinting students found on canvas: " + str(len(students)))
print("-----------------------")
for student in students:
  print(student.name)
print()

# Get the assignment object
assignments = course.get_assignments(search_term=ASSIGNMENT_TO_GRADE)
assignment = assignments[0]
print("you are grading assignment: " + assignment.name + "\n")

# Check for Valgrind leaks
for student, github in zip(students, studentGithubs):

  print("You are grading: " + student.name + " (" + github + ")")
  try:
    messages = getValgrindBlocks(github)
    if(len(messages) > 0):
      for message in messages:
        print(message)
      print()
    else:
      print("No leaks detected!\n")
  except:
    print("Could not find valgrind file, probably did not run.")
  
  # Output Comparison
  try:
    studentOut = open('./projects/' + SEMESTER + "-" + ASSIGNMENT_TO_GRADE.replace(" ", "").lower() + "-" + github + "/" + outFile[0: -1])
    realOut = open('./configs/desiredOutput.txt')
    text1 = studentOut.read()
    text2 = realOut.read()
    studentOut.close()
    realOut.close()
    m = SequenceMatcher(None, text1, text2)
    studentOut = open('./projects/' + SEMESTER + "-" + ASSIGNMENT_TO_GRADE.replace(" ", "").lower() + "-" + github + "/" + outFile[0: -1])
    realOut = open('./configs/desiredOutput.txt')
    text1 = studentOut.readlines()
    text2 = realOut.readlines()
    d = Differ()
    result = list(d.compare(text1, text2))
    pprint(result)
    print("Their matching ratio is: " + str(round(m.ratio() * 100,0)) + "%")
  except Exception as e:
    print (e)
    print("student output or desired output not found. (Maybe the program didn't run properly?)")
    
  # Grade the student's submission
  grade = input("What grade would you like to give " + student.name + "? Or enter a non-number to skip: ")
  if grade.isnumeric():
    print("changing grade to: " + str(grade) + "\n")
    # submission = assignment.get_submission(student)
    # submission.edit(submission={'posted_grade':int(grade)})
  else:
    print("non-number detected. Skipping grading of student.\n")
    continue
  