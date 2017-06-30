output_file = open('FoundVertices.txt', 'w')

with open('DeleteResults.txt') as input_file:
    i = 0
    for line in input_file:
        i += 1
        if i == 1 or i == 2:
            continue
        newline = line.lstrip().split(" ")
        graph6 = newline[0].rstrip()
        space = len(line) - len(line.lstrip(' '))
        if len(newline) == 2:
            output_file.write(space*" " + graph6 + ": {} {} {}\n".format(Graph(graph6).order(), len(Graph(graph6).independent_set()), int(newline[1].rstrip())-2))
        else:
            output_file.write(line[:-2] + ": {} {}\n".format(Graph(graph6).order(), len(Graph(graph6).independent_set())))
