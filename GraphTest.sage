load('check.sage')
output_file = open('Cubic.txt','a+')
for j in range(22,23,2):
    i = 0
    print "graphs on {} vertices".format(j)
    output_file.write("Graphs on {} vertices:".format(j))
    output_file.write("\n")
    with open('/Users/zgmdocks/Downloads/cub{num1:02d}.g6.txt'.format(num1=j,num2=j)) as input_file:
        for line in input_file:
            i += 1
            print "graph {} on {} vertices".format(i,j)
            G = Graph(line)
            if (check(G)):
                print "{} does not have a tight bound".format(line)
                output_file.write(line)



        
