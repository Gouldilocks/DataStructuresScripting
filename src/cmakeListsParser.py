import os
import sys

# Parser which searches the Cmakelists.txt file for the name of the executable, and puts it into executableName.txt
def main():
    print("Starting Python Script")
    filepath = sys.argv[1]
    f = open(filepath,'r')
    lines = []
    with f:
        lines = f.readlines()
    if os.path.isfile('../../dontTouchMe/executableName.txt'):
        os.remove('../../dontTouchMe/executableName.txt')
    toWrite = open('../../dontTouchMe/executableName.txt', 'w')
    count = 0
    for line in lines:
        if 'add_executable(' in line:
            parenth = line.find('(')
            space = line.find(' ', parenth, len(line))
            executable_name = line[parenth + 1: space]
            print("executable name: " + executable_name)
            toWrite.write(executable_name)


if __name__ == '__main__':
    main()
