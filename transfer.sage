output_file = open('FoundVertices.txt', 'w')
treeWidths = {}

with open('TreeWidths.txt') as Input_file:
    for line in Input_file:
        graphString,width = line.rstrip().split(" ")
        treeWidths[graphString] = width

treewidth_file = open('TreeWidths.txt', 'w')

for g in treeWidths:
    treewidth_file.write("{} {}\n".format(g, treeWidths[g]))
treewidth_file.flush()
print treeWidths

with open('DeleteResults.txt') as input_file:
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
        if space == 0:
            primary = i-2
        TreeWidth = None
        if graph6 in treeWidths:
            TreeWidth = treeWidths[graph6]
        else:
            TreeWidth = Graph(graph6).treewidth(algorithm="sage")
            treeWidths[graph6] = TreeWidth
            treewidth_file.write("{} {}\n".format(graph6, TreeWidth))
            treewidth_file.flush()
        if len(newline) == 2:
            lastSeen = int(newline[1].rstrip())-2
            ending = ""
            if lastSeen <= primary:
                ending = "********************"
            output_file.write(space*" " + graph6 + " order:{} TW:{} alpha:{} LS:{} {}\n".format(Graph(graph6).order(), TreeWidth, len(Graph(graph6).independent_set()), lastSeen, ending))
        else:
            output_file.write(space*" " + graph6 + " order:{} TW:{} alpha:{}\n".format(Graph(graph6).order(), TreeWidth, len(Graph(graph6).independent_set())))
        output_file.flush()
