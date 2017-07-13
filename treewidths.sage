output_file = open("TreeWidths.txt","w")

with open("FoundVertices.txt") as input_file:
    for line in input_file:
        words = line.lstrip().split(" ")
        width = words[2][3:]
        graph = words[0]
        output_file.write("{} {}\n".format(graph,width))
