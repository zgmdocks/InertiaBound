output_file = open('FoundVertices.sage', 'a')

with open('DeleteResults.txt') as input_file:
    for line in input_file:
        graph6 = line
        graph6 = graph6.lstrip()
        print graph6
        output_file.write(line[:-2] + ": {}\n".format(Graph(graph6).order()))

