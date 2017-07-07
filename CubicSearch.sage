load('check.sage')
output_file = open('CubicVT.txt','a+')
with open('cubicvt4-300g6.txt') as input_file:
    start = int(input_file.readline())
    j = 1
    while j < start:
        input_file.readline()
        j += 1
    for line in input_file:
        line = line.rstrip()
        j += 1
        G = Graph(line)
        G.allow_loops(False)
        G.allow_multiple_edges(False)
        print "graph {} on {} vertices".format(j-1,G.order())
        print line
        if (check(G)):
            print "{} does not have a tight bound *****************".format(line)
            output_file.write(line + "\n")
        firstLine = open('cubicvt4-300g6.txt','r+')
        firstLine.write(str(j) + "\n")
        firstLine.close()
