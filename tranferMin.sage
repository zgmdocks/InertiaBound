output_file = open('MinimalVertices.txt', 'w')

with open('Minimal.txt') as input_file:
    i = 0
    primary = 1
    for line in input_file:
        i += 1
        print i
        if i == 1 or i == 2:
            continue
        newline = line.lstrip().split(" ")
        graph6 = newline[0].rstrip()
        space = len(line) - len(line.lstrip(' '))
        output_file.write(space*" " + graph6 + " order:{} alpha:{}\n".format(Graph(graph6).order(), len(Graph(graph6).independent_set())))
        output_file.flush()
