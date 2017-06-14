load('check.sage')
output_file = open('delVtx.txt','a+')
i = 0
with open('/Users/zgmdocks/Downloads/DeleteFourth.txt') as input_file:
    for line in input_file:
        i += 1
        G = Graph(line)
        print "graph {} on {} vertices".format(i,G.order())
        if (check(G)):
            print "{} does not have a tight bound".format(line)
            output_file.write(line)



        
