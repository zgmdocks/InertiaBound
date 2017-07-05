import copy

smallest = None
smallestG = set()
output_file = open("shared.txt","w")
with open("FoundVertices.txt") as input_file:
    input_file.readline()
    input_file.readline()
    parent = None
    for line in input_file:
        space = len(line) - len(line.lstrip())
        words = line.lstrip().rstrip().split(" ")
        graph = words[0][:-1]
        numV = int(words[1])
        if smallest:
            if numV < smallest:
                smallest = numV
                smallestG = set([graph])
            elif numV == smallest:
                smallestG.add(graph)
        else:
            smallest = numV
            smallestG = set([graph])

print smallestG
print len(smallestG)
print smallest


