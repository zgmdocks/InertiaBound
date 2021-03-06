import types
output_file = open('FoundVertices.txt', 'w')
treeWidths = {}
smallest = None
with open('TreeWidths.txt') as Input_file:
    for line in Input_file:
        graphString,width = line.rstrip().split(" ")
        treeWidths[graphString] = width
        if width != "-1":
            if smallest == None:
                smallest = int(width)
            elif int(width) < smallest:
                smallest = int(width)

print smallest

treewidth_file = open('TreeWidths.txt', 'w')

for g in treeWidths:
    treewidth_file.write("{} {}\n".format(g, treeWidths[g]))

treewidth_file.flush()

output_file.write("smallest TW: {}\n".format(smallest))

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
            TreeWidth = Graph(graph6).treewidth(k=smallest,algorithm="sage")
            if TreeWidth:
                TreeWidth = Graph(graph6).treewidth(algorithm="sage")
                smallest = TreeWidth
            elif TreeWidth == False:
                TreeWidth = -1
            treeWidths[graph6] = TreeWidth
            treewidth_file.write("{} {}\n".format(graph6, TreeWidth))
            treewidth_file.flush()
        if len(newline) == 2:
            lastSeen = int(newline[1].rstrip())-1
            ending = ""
            if lastSeen <= primary:
                ending = "********************"
            output_file.write(space*" " + graph6 + " order:{} TW:{} alpha:{} LS:{} {}\n".format(Graph(graph6).order(), TreeWidth, len(Graph(graph6).independent_set()), lastSeen, ending))
        else:
            output_file.write(space*" " + graph6 + " order:{} TW:{} alpha:{}\n".format(Graph(graph6).order(), TreeWidth, len(Graph(graph6).independent_set())))
        output_file.flush()
