def signing(G, signings, subgraph):
    triangle = graphs.CompleteGraph(3)
    # triSign is used to keep track of the sign of every triangle
    for triSign in [1,2]:
        print "sign of triangles is " + triSign

