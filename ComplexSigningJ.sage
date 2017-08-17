g = Graph("J`]T?KTGyR_")
M = matrix([[0.000000000000000,-9.03812720168832,0.000000000000000,0.000000000000000,0.000000000000000,2.98318272956641,7.24485650222807,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000],[-9.03812720168832,0.000000000000000,0.000000000000000,0.000000000000000,-2.98857157888063,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,-8.75559237804516],[0.000000000000000,0.000000000000000,0.000000000000000,-4.36276599207732,1.34834224582235,0.000000000000000,6.20439131648802,0.000000000000000,0.000000000000000,-4.42038642894444,0.000000000000000],[0.000000000000000,0.000000000000000,-4.36276599207732,0.000000000000000,3.53615656575768,-9.41250384645531,0.000000000000000,0.000000000000000,3.15329610027660,0.000000000000000,0.000000000000000],[0.000000000000000,-2.98857157888063,1.34834224582235,3.53615656575768,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,6.11210594725489],[2.98318272956641,0.000000000000000,0.000000000000000,-9.41250384645531,0.000000000000000,0.000000000000000,0.000000000000000,3.74830822968688,-9.86510349383307,0.000000000000000,0.000000000000000],[7.24485650222807,0.000000000000000,6.20439131648802,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,-6.51229265870590,0.000000000000000,-1.21638183019483,0.000000000000000],[0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,0.000000000000000,3.74830822968688,-6.51229265870590,0.000000000000000,-9.30051528958830,5.38434926464192,8.22219492068751],[0.000000000000000,0.000000000000000,0.000000000000000,3.15329610027660,0.000000000000000,-9.86510349383307,0.000000000000000,-9.30051528958830,0.000000000000000,-2.94228255743933,-5.67602474894628],[0.000000000000000,0.000000000000000,-4.42038642894444,0.000000000000000,0.000000000000000,0.000000000000000,-1.21638183019483,5.38434926464192,-2.94228255743933,0.000000000000000,7.59706050678039],[0.000000000000000,-8.75559237804516,0.000000000000000,0.000000000000000,6.11210594725489,0.000000000000000,0.000000000000000,8.22219492068751,-5.67602474894628,7.59706050678039,0.000000000000000]]) 

def is_cycle(G):
    vertices = G.vertices()
    for v in vertices:
        if G.degree(v) != 2:
            return False
    numVertices = G.order()
    lastVert = vertices[0]
    currVert = G.neighbors(lastVert)[0]
    seen = 2
    alreadySeen = set()
    alreadySeen.add(lastVert)
    alreadySeen.add(currVert)
    while True:
        neighbors = G.neighbors(currVert)
        if neighbors[0] != lastVert:
            lastVert = currVert
            currVert = neighbors[0]
        else:
            lastVert = currVert
            currVert = neighbors[1]
        if currVert in alreadySeen:
            break
        alreadySeen.add(currVert)
        seen += 1
    if seen != numVertices:
        return False
    return True
    

def ComplexSigning(G,m):
    numVertices = G.order()
    alpha = len(G.independent_set())
    subgraphs = {}
    for combo in Combinations(numVertices,2*alpha+1):
        I = G.subgraph(combo,immutable=true)
        #this next while loop will delete all pendants of g,
        #then check if the resulting g is a: a single odd cycle
        # or b: a disjoint union of odd cycles. if it is in category
        # a, then it is added to trainglesCheck list, and if it is in b,
        # it is added to subgraphs list
        h = G.subgraph(combo)
        # this changed variable is necessary because when we iterate through the
        # vertices, we are deleting some and creating new pendants that we need
        # to delete also, but if we already iterated over that vertex, then
        # we won't realize that it still needs to be deleted so we need to
        # keep iterating over the vertices until we get to a point where we don't
        # find and delete any new pendants
        changed = True
        while changed:
            changed = False
            for v in h.vertex_iterator():
                if len(h[v]) == 1:
                    changed = True
                    h.delete_vertex(h[v][0])
                    h.delete_vertex(v)
                    break
        components = h.connected_components_subgraphs()
        if not components:
            break
        continue_loop = False
        for com in components:
            if (not is_cycle(com)) or (not com.order()%2 == 1):
                continue_loop = True 
                # need continue_loop because I want to continue out of outer for
                # loop, but using continue now will only continue out of 
                # the inner for loop
                break
        if continue_loop:
            continue
        # if we make it to this point, every component was an odd cycle
        subgraphs[I] = h
    pos = {}
    neg = {}
    for s in subgraphs.keys():
        vertices = s.vertices()
        submatrix = m[vertices,vertices]
        if submatrix.determinant() > 0:
            pos[s] = subgraphs[s]
        elif submatrix.determinant() < 0:
            neg[s] = subgraphs[s]
        else:
            print "subgraph with vertices {} has a zero determinant".format(vertices)
    print "Subgraphs with positive determinants:"
    for p in pos.keys():
        print "{} : {}".format(p.vertices(),pos[p].vertices())
    print "Subgraphs with negative determinants:"
    for n in neg.keys():
        print "{} : {}".format(n.vertices(),neg[n].vertices())

ComplexSigning(g,M)
