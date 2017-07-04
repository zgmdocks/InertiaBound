sharedGraphs = {}

output_file = open("shared.txt","w")
with open("FoundVertices.txt") as input_file:
    input_file.readline()
    input_file.readline()
    parent = None
    for line in input_file:
        space = len(line) - len(line.lstrip())
        words = line.lstrip().rstrip().split(" ")
        graph = words[0][:-1]
        if space == 0:
            parent = graph
        if line[-4] == "*":
            if graph in sharedGraphs:
                temp = sharedGraphs[graph]
                temp.add(parent)
                sharedGraphs[graph] = temp
            else:
                sharedGraphs[graph] = set([parent])

with open("FoundVertices.txt") as input_file:
    input_file.readline()
    input_file.readline()
    parent = None
    for line in input_file:
        space = len(line) - len(line.lstrip())
        words = line.lstrip().rstrip().split(" ")
        graph = words[0][:-1]
        if space == 0:
            parent = graph
        if graph in sharedGraphs:
            temp = sharedGraphs[graph]
            temp.add(parent)
            sharedGraphs[graph] = temp

for g in sharedGraphs:
    output_file.write(g + " {}\n".format(Graph(g).order()))
    for p in sharedGraphs[g]:
        output_file.write(" "*4 + "{} {}\n".format(p, Graph(p).order()))


 
