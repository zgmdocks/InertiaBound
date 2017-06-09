load('check.sage')
output_file = open('Cubic.txt','a+')
for j in range(10,23,2):
    i = 0
    print "graphs on {} vertices".format(j)
    output_file.write("Graphs on {} vertices:".format(j))
    output_file.write("\n")
    with open('/Users/zgmdocks/Downloads/cub{num1:02d}.g6.txt'.format(num1=j,num2=j)) as input_file:
        for line in input_file:
            i += 1
            print "graph {} on {} vertices".format(i,j)
            H = Graph(line)
            G = Graph(H.order())
            for v in G.vertex_iterator():
                for v2 in G.vertex_iterator():
                        if v2 not in H[v] and v2 != v:
                            G.add_edge(v,v2)
            if G.is_vertex_transitive():
                print "Vertex Transitive"
                continue
            if (check(G)):
                print "{} does not have a tight bound".format(line)
                output_file.write(line)



        
