#contained returns true if the each triangle in G is contained in at least one subgraph of the form SubGraph and
#false otherwise
def contained(G, Triangle, SubGraph):
    j = 1
    #calculates the total number of triangles in G
    for triangle in G.subgraph_search_iterator(Triangle,induced = true):
        if j == 0:
            # if j = 0, we did not find the triangle in any subgraph
            return false
        j = 0
        for subgraph in G.subgraph_search_iterator(SubGraph,induced = true):
            # we want to break if the triangle is contained in the current subgraph and start checking the next triangle
            if set(triangle).issubset(set(subgraph)):
                j = 1
                break
    return true

g=graphs.CirculantGraph(17,[1, 2, 4, 8])
T = graphs.CompleteGraph(3)
H = Graph("F@LSW")

g.show()
T.show()
H.show()
print contained(g,T,H)
