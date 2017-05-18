import os
# signing accepts a graph G, a matrix that will hold the signs of edges, M, and
# a list of nonsingular subgraphs of G of size 2alpha+1. This function will
# attempt to determine the signing of G and find a contradiction for a tight
# inertia bound using the list of subgraphs. M will hold the signs of the edges
# throughout. M[i,j] will equal 1 if the edge between vertices i and j is
# positive, -1 if the edge is positive, 0 if there is no edge, and 10 if
# there is an edge but we have not determined the sign yet.
def signing(G, M, subgraphs, triSign):
    triangle = graphs.CompleteGraph(3)
    alpha = len(G.independent_set())
    #posEigen and negEigen are sets where if a subgraph belongs to posEigen
    #it has alpha(G)+1 positive Eigevalues, and if it belongs to negEigen
    #it has alpha(G)+1 negative eigenvalues
    posEigen = set()
    negEigen = set()
    print "sign of triangles is {}".format(triSign)
    changed = True
    while True:
        if changed == False:
            n = G.order()
            for i in range(n):
                for j in range(n):
                    if M[i,j] == 10:
                        print i
                        print j
            print M
            break
        changed = True
        for t in G.subgraph_search_iterator(triangle,induced=true):
            # since we let M[i,j] = 10 if we didn't know the sign of the
            # edge, we know that if we don't know two edges, the sum of
            # the edges will be 19 at the least. Thus, if the sum is less
            # then 19, we know at least two edges. Also, if the sum is
            # >= 8, then we know we only have 1 missing edge and can determine it
            if (M[t[0],t[1]] + M[t[0],t[2]] + M[t[1],t[2]] < 19) and (M[t[0],t[1]] + M[t[0],t[2]] + M[t[1],t[2]] >= 8):
                    print "triangle is {}-{}-{}".format(t[0],t[1],t[2])
                    print "signs are {}-{}: {}, {}-{}: {}, {}-{}: {}".format(t[0],t[1],M[t[0],t[1]],t[0],t[2],M[t[0],t[2]],t[1],t[2],M[t[1],t[2]])
                    if M[t[0],t[1]] == 10:
                        M[t[0],t[1]] = triSign*M[t[0],t[2]]*M[t[1],t[2]]
                        M[t[1],t[0]] = triSign*M[t[0],t[2]]*M[t[1],t[2]]
                    if M[t[0],t[2]] == 10:
                        M[t[0],t[2]] = triSign*M[t[0],t[1]]*M[t[1],t[2]]
                        M[t[2],t[0]] = triSign*M[t[0],t[1]]*M[t[1],t[2]]
                    if M[t[1],t[2]] == 10:
                        M[t[1],t[2]] = triSign*M[t[0],t[1]]*M[t[0],t[2]]
                        M[t[2],t[1]] = triSign*M[t[0],t[1]]*M[t[0],t[2]]
                    changed = True
        for s in subgraphs:
            edgeSigned = True
            for e in s.edge_iterator(labels=false):
                if M[e[0],e[1]] == 10:
                    edgeSigned = False
                    break
            if edgeSigned == False:
                continue
            # if we get to this point, we know that all edges in the subgraph have a
            # sign and so we can determine if it should be in posEigen of negEigen
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
            print "Found a contradictory case"
            print M
            graphic1 = posEigen.pop().plot()
            graphic2 = negEigen.pop().plot()
            graphic1.save('subgraph1-{}.png'.format(triSign))
            os.system('open subgraph1-{}.png'.format(triSign))
            graphic2.save('subgraph2-{}.png'.format(triSign))
            os.system('open subgraph2-{}.png'.format(triSign))
            return True
    print "did not find a contradiction"
    return False



