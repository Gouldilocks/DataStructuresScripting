import os
import sys


def main():
    print("Starting Python Script")
    filepath = sys.argv[1]
    f = open(filepath,'r')
    lines = []
    with f:
        lines = f.readlines()
    if os.path.isfile('../../executableName.txt'):
        os.remove('../../executableName.txt')
    toWrite = open('../../executableName.txt', 'w')
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
