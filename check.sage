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
    circuit = G.eulerian_circuit()
    if not circuit:
        return False
    if not G.is_arc_transitive():
        return False
    subgraphs = []
    for combo in Combinations(range(numVertices,2*alpha+1)):
        g = G.subgraph(combo)
        if nonsingular_graph(g):
            stg = g.canonical_label.graph6_string()
            if stg not in subgraphs:
                subgraphs.append(stg)

    return True



# contained returns true if the each triangle in G is
# contained in at least one subgraph of the form SubGraph and
# false otherwise
def contained(G, Triangle, SubGraph):
    j = 1 
    #calculates the total number of triangles in G
    for triangle in G.subgraph_search_iterator(Triangle,induced = true):
        if j == 0:
            # if j = 0, we did not find the triangle in any subgraph
            return False
        j = 0 
        for subgraph in G.subgraph_search_iterator(SubGraph,induced = true):
            # we want to break if the triangle is contained in the current 
            #subgraph and start checking the next triangle
            if set(triangle).issubset(set(subgraph)):
                j = 1 
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




nonsingular_graph(g):
    """
    Return True if g is nonsingular, otherwise return False.  
    The algorithm keeps deleting a leaf and its only neighbor.  If the final graph 
    is a disjoint union of odd cycles, then g is nonsingular.
    
    Input:
        g: a simple graph (considered as no loop)
    Output:
        True or False
    """
    if g.order()==0:
        return True;
    com=g.connected_components_subgraphs()[0]
    V=com.vertices();
    ##If has a leaf, then delete the leaf and its neighbor.
    for v in V:
        if g.degree(v)==1:
            u=g.neighbors(v)[0];
            h=g.copy();
            h.delete_vertex(v);
            h.delete_vertex(u);
            return nonsingular_graph(h);
    ##If no leaf, check odd cycle or not.
    deg_seq=com.degree_sequence();
    if max(deg_seq)==2 and min(deg_seq)==2 and com.order()%2==1:
        h=g.copy();
        for v in V:
            h.delete_vertex(v);
        return nonsingular_graph(h);
    else:
        return False;
