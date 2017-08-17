g = Graph("J`]T?KTGyR_")

M = matrix(CDF,[[0,-9,0,0,0,3,7.2,0,0,0,0],[-9,0,0,0,-3,0,0,0,0,0,-8.8],[0,0,0,-4.4,1.3,0,6.2,0,0,-4.4,0],[0,0,-4.4,0,3.5,-9.4,0,0,3.2,0,0],[0,-3,1.3,3.5,0,0,0,0,0,0,6.1],[3,0,0,-9.4,0,0,0,3.7,-9.9,0,0],[7.2,0,6.2,0,0,0,0,-6.5,0,-1.2,0],[0,0,0,0,0,3.7,-6.5,0,-9.3,5.4,8.2],[0,0,0,3.2,0,-9.9,0,-9.3,0,-2.9,-5.7],[0,0,-4.4,0,0,0,-1.2,5.4,-2.9,0,7.6],[0,-8.8,0,0,6.1,0,0,8.2,-5.7,7.6,0]])
print M.is_hermitian()
print [real(x) for x in M.eigenvalues()]
print "Inertia Bound: {}".format(min(sum(real(x)>=0 for x in M.eigenvalues()), sum(real(x)<=0 for x in M.eigenvalues())))

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
            if (not com.is_cycle()) or (not com.order()%2 == 1):
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
    det = {}
    for s in subgraphs.keys():
        vertices = s.vertices()
        submatrix = m[vertices,vertices]
        det[s] = submatrix.determinant()
        if submatrix.determinant() > 0:
            pos[s] = subgraphs[s]
        elif submatrix.determinant() < 0:
            neg[s] = subgraphs[s]
        else:
            print "subgraph with vertices {} has a zero determinant".format(vertices)
    print "Subgraphs with positive determinants: {}".format(len(pos))
    for p in pos.keys():
        print "subgraph: {}, odd cycle: {}, Determinant: {}".format(p.vertices(),pos[p].vertices(),det[p])
    print "Subgraphs with negative determinants: {}".format(len(neg))
    for n in neg.keys():
        print "subgraph: {}, odd cycle: {} {}".format(n.vertices(),neg[n].vertices(),neg[n].edges())

ComplexSigning(g,M)
