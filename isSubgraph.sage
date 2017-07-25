g = Graph("J`]T?KTGyR_")
h = Graph("Jtv`plZXy^_")

def isomorphic_subgraph(orig,subgraph):
    checked = set()
    size = subgraph.order()
    numVertices = orig.order()
    count = 0
    for combo in Combinations(numVertices,size):
        count += 1
        I = orig.subgraph(combo,immutable=true)
        if I in checked:
            continue
        if I.is_isomorphic(subgraph):
            return True
    print count
    return False

output = open("Subgraphof.txt","w")

with open("original19NoCanon.txt") as input_file:
    output.write(g.graph6_string() + " alpha:{}\n".format(len(g.independent_set())))
    output.write(h.graph6_string() + " alpha:{}\n".format(len(h.independent_set())))
    counter = 0
    for line in input_file:
        counter += 1
        if counter < 0:
            continue
        G = Graph(line.rstrip())
        print line.rstrip()
        g_search = G.subgraph_search(g)
        h_search = G.subgraph_search(h)
        if g_search and h_search:
            print True
            output.write(line.rstrip() + " alpha:{} subgraphs: {} {}\n".format(len(G.independent_set()),g.graph6_string(),h.graph6_string()))
        elif g_search:
            output.write(line.rstrip() + " alpha:{} subgraphs: {}\n".format(len(G.independent_set()),g.graph6_string()))
        elif h_search:
            output.write(line.rstrip() + " alpha:{} subgraphs: {}\n".format(len(G.independent_set()),h.graph6_string()))
        else:
            output.write(line.rstrip() + " alpha:{} subgraphs:\n".format(len(G.independent_set())))
            print False
        


