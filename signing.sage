import os
#this debug variable is to control the output to the screen. If it is set to true,
#steps of the process will be printed to the screen. If it is false, the functions will
#not output anything to the screen.
debug = True
# signing accepts a graph G, a matrix that will hold the signs of edges, M, and
# a list of nonsingular subgraphs of G of size 2alpha+1. This function will
# attempt to determine the signing of G and find a contradiction for a tight
# inertia bound using the list of subgraphs. M will hold the signs of the edges
# throughout. M[i,j] will equal 1 if the edge between vertices i and j is
# positive, -1 if the edge is positive, 0 if there is no edge, and 10 if
# there is an edge but we have not determined the sign yet.
# triangles is the set of all triangles we know must be the same sign
def signing(G, M, subgraphs, triSign, Triangles):
    alpha = len(G.independent_set())
    #posEigen and negEigen are sets where if a subgraph belongs to posEigen
    #it has alpha(G)+1 positive Eigevalues, and if it belongs to negEigen
    #it has alpha(G)+1 negative eigenvalues
    posEigen = set()
    negEigen = set()
    if debug:
        print "sign of triangles is {}".format(triSign)
    changed = True
    i = 0
    while True:
        changed = False
        for t in Triangles:
            # since we let M[i,j] = 10 if we didn't know the sign of the
            # edge, we know that if we don't know two edges, the sum of
            # the edges will be 19 at the least. Thus, if the sum is less
            # then 19, we know at least two edges. Also, if the sum is
            # >= 8, then we know we only have 1 missing edge and can determine it
            if (M[t[0],t[1]] + M[t[0],t[2]] + M[t[1],t[2]] < 19) and (M[t[0],t[1]] + M[t[0],t[2]] + M[t[1],t[2]] >= 8):
                if debug:
                    i += 1
                    print "step {}:".format(i)
                    print "triangle is {}-{}-{}".format(t[0],t[1],t[2])
                    print "signs are {}-{}: {}, {}-{}: {}, {}-{}: {}".format(t[0],t[1],M[t[0],t[1]],t[0],t[2],M[t[0],t[2]],t[1],t[2],M[t[1],t[2]])
                if M[t[0],t[1]] == 10:
                    if debug:
                        print "new sign is: {}".format(triSign*M[t[0],t[2]]*M[t[1],t[2]])
                    M[t[0],t[1]] = triSign*M[t[0],t[2]]*M[t[1],t[2]]
                    M[t[1],t[0]] = triSign*M[t[0],t[2]]*M[t[1],t[2]]
                if M[t[0],t[2]] == 10:
                    if debug:
                        print "new sign is: {}".format(triSign*M[t[0],t[1]]*M[t[1],t[2]])
                    M[t[0],t[2]] = triSign*M[t[0],t[1]]*M[t[1],t[2]]
                    M[t[2],t[0]] = triSign*M[t[0],t[1]]*M[t[1],t[2]]
                if M[t[1],t[2]] == 10:
                    if debug:
                        print "new sign is: {}".format(triSign*M[t[0],t[1]]*M[t[0],t[2]])
                    M[t[1],t[2]] = triSign*M[t[0],t[1]]*M[t[0],t[2]]
                    M[t[2],t[1]] = triSign*M[t[0],t[1]]*M[t[0],t[2]]
                changed = True
        if changed == False:
            n = G.order()
            if debug:
                print "edges that are undetermined:"
            for i in range(n):
                for j in range(n):
                    if M[i,j] == 10:
                        if debug:
                            print i,j
            if debug:
                print M
            break    
        #This loop will once again loop through all triangles, but this time, it will make sure
        #that all the signings that were made in the last loop were valid. (may be unneccessary)
        for t in Triangles:
            if (M[t[0],t[1]] + M[t[0],t[2]] + M[t[1],t[2]] < 8):
                if (M[t[0],t[1]]*M[t[0],t[2]]*M[t[1],t[2]] != triSign):
                    if debug:
                        print "triangle {}-{}-{} is not valid".format(t[0],t[1],t[2])
                        print "signs are {}-{}: {}, {}-{}: {}, {}-{}: {}".format(t[0],t[1],M[t[0],t[1]],t[0],t[2],M[t[0],t[2]],t[1],t[2],    M[t[1],t[2]])
                    return True
        #This loop is used to look through subgraphs and find subgraphs that have fully been signed
        #so we can put them in posEigen or negEigen
        for s in subgraphs:
            edgeSigned = True
            for e in s.edge_iterator(labels=false):
                if M[e[0],e[1]] == 10:
                    edgeSigned = False
                    break
            if edgeSigned == False:
                continue
            # if we get to this point, we know that all edges in the subgraph have a
            # sign and so we can determine if it should be in posEigen or negEigen
            c = s.copy(immutable=False)
            for e in c.edge_iterator(labels=false):
                temp1 = e[0]
                temp2 = e[1]
                c.delete_edge(e)
                c.add_edge((temp1,temp2,M[temp1,temp2]))
            if sum(x>0 for x in c.weighted_adjacency_matrix().eigenvalues()) == alpha+1:
                posEigen.add(s)
            else:
                negEigen.add(s)
        if posEigen and negEigen:
            if debug:
                print "Found a contradictory case"
                print M
                subgraph1 = posEigen.pop()
                subgraph2 = negEigen.pop()
                subgraph1c = subgraph1.copy(immutable = False)
                subgraph2c = subgraph2.copy(immutable = False)
                for e in subgraph1c.edge_iterator(labels=false):
                    temp1 = e[0]
                    temp2 = e[1]
                    subgraph1c.delete_edge(e)
                    subgraph1c.add_edge((temp1,temp2,M[temp1,temp2]))
                for e in subgraph2c.edge_iterator(labels=false):
                    temp1 = e[0]
                    temp2 = e[1]
                    subgraph2c.delete_edge(e)
                    subgraph2c.add_edge((temp1,temp2,M[temp1,temp2]))
                print subgraph1c.weighted_adjacency_matrix().eigenvalues()
                print subgraph2c.weighted_adjacency_matrix().eigenvalues()
                graphic1 = subgraph1.plot()
                graphic2 = subgraph2.plot()
                graphic1.save('subgraph1^{}.png'.format(triSign))
                os.system('open subgraph1^{}.png'.format(triSign))
                graphic2.save('subgraph2^{}.png'.format(triSign))
                os.system('open subgraph2^{}.png'.format(triSign))
            return True
    if debug:
        print "did not find a contradiction"
    return False



