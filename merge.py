import sys

if len(sys.argv) != 4:
    print("Invalid number of arguments should be: [file1] [file2] [outfile]")

files = [sys.argv[1], sys.argv[2]]

all_lines = []
for f in files:
    with open(f, 'r') as fi:
        all_lines += fi.readlines()
all_lines = set(all_lines)

with open(sys.argv[3], 'w') as fo:
    fo.write("".join(all_lines))
