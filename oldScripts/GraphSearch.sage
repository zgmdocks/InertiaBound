load('check.sage')
output_file = open('CubicVT.txt','a+')
i = 0
with open('/Users/zgmdocks/Downloads/cubicvt4-300g6.txt') as input_file:
    for line in input_file:
        i += 1
        G = Graph(line)
        G.allow_loops(False)
        G.allow_multiple_edges(False)
        print "graph {} on {} vertices".format(i,G.order())
        if (check(G)):
            print "{} does not have a tight bound".format(line)
            output_file.write(line)



        
