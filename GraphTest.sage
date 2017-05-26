load('check.sage')
output_file = open('GraphsBig.txt','a+')
for j in range(24,30):
    i = 0
    print "graphs on {} vertices".format(j)
    output_file.write("Graphs on {} vertices:".format(j))
    output_file.write("\n")
    with open('/Users/zgmdocks/Downloads/VertexTransitiveGraphs/trans{num1:02d}/trans{num2:02d}c.g6'.format(num1=j,num2=j)) as input_file:
        for line in input_file:
            i += 1
            if j == 24 and i < 1204:
                continue
            print "graph {} on {} vertices".format(i,j)
            G = Graph(line)
            if (check(G)):
                print "{} does not have a tight bound".format(line)
                output_file.write(line)



        
