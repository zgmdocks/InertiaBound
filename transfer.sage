output_file = open('FoundVertices.txt', 'w')

with open('DeleteResults.txt') as input_file:
    i = 0
    primary = 1
    for line in input_file:
        i += 1
        if i == 1 or i == 2:
            continue
        newline = line.lstrip().split(" ")
        graph6 = newline[0].rstrip()
        space = len(line) - len(line.lstrip(' '))
        if space == 0:
            primary = i-2
        if len(newline) == 2:
            lastSeen = int(newline[1].rstrip())-2
            ending = ""
            if lastSeen <= primary:
                ending = "********************"
            output_file.write(space*" " + graph6 + ": {} {} {} {}\n".format(Graph(graph6).order(), len(Graph(graph6).independent_set()), lastSeen, ending))
        else:
            output_file.write(space*" " + graph6 + ": {} {}\n".format(Graph(graph6).order(), len(Graph(graph6).independent_set())))
