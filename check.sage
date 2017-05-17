import os
# check takes a graph G as input and returns true if the 
# graph satisfies all properties that would make
# it a good candidate for the method used in John 
# Sinkovic's Paper to find an inertia bound that
# is not tight
def check(G):
    alpha = len(G.independent_set())
    numVertices = len(G)
    if not is_alpha_critical(G):
        return False
    path = G.hamiltonian_path()
    if not path:
        return False
    if not G.is_arc_transitive():
        return False
    subgraphs = []
    trianglesCheck = []
    for combo in Combinations(range(numVertices),2*alpha+1):
        g = G.subgraph(combo)
        st = g.graph6_string()
        #this next while loop will delete all pendants of g,
        #then check if the resulting g is a: a single odd cycle
        # or b: a disjoint union of odd cycles. if it is in category
        # a, then it is added to trainglesCheck list, and if it is in b,
        # it is added to subgraphs list
        h = g.copy()
        # this changed variable is necessary because when we iterate through the
        # vertices, we are deleting some and creating new pendants that we need
        # to delete also, but if we already iterated over that vertice, then
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
        if h.is_cycle() and h.order()%2 == 1:
            if st not in trianglesCheck:
                trianglesCheck.append(st)
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
        if st not in subgraphs:
            subgraphs.append(st)
    T = graphs.CompleteGraph(3)
    if not contained(G,T,trianglesCheck):
        return False
    # finished preliminary check, now to check signs
    print "Check passed"
    print len(subgraphs)
    return True


#Thinking this is working correctly, but might need to come back to
# contained returns true if the each triangle in G is
# contained in at least one subgraph of the form SubGraph and
# false otherwise
def contained(G, Triangle, SubGraphs):
    j = 1 
    #calculates the total number of triangles in G
    for triangle in G.subgraph_search_iterator(Triangle,induced = true):
        if j == 0:
            # if j = 0, we did not find the triangle in any subgraph
            return False
        j = 0
        for st in SubGraphs:
            s = Graph(st)
            for subgraph in G.subgraph_search_iterator(s,induced = true):
                # we want to break if the triangle is contained in the current 
                #subgraph and start checking the next triangle
                if set(triangle).issubset(set(subgraph)):
                    j = 1 
                    break
            if j == 1:
                break
    return True



# is_alpha_critical returns true if the graph G is alpha critical
def is_alpha_critical(G):
    alpha=len(G.independent_set())
    for i in G.edges():
        H=G.copy()
        H.delete_edge(i)
        if len(H.independent_set())==alpha:
            return False
    return True

g = graphs.CirculantGraph(17,[1,2,4,8])
graphic = g.plot()
graphic.save('output.png')
os.system('open output.png')
print check(g)
