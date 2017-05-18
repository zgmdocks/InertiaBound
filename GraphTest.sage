load('check.sage')
i = 0
with open('/Users/zgmdocks/Downloads/VertexTransitiveGraphs/trans17/trans17c.g6') as input_file:
    for line in input_file:
        i += 1
        print "graph {}".format(i)
        G = Graph(line)
        if (check(G)):
            print "{} does not have a tight bound".format(line)

        
