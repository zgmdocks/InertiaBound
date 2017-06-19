load("check.sage")
output_file = open('DeleteResults.txt','a+')
graphs_checked = open('CheckedBad.txt','a+')
allGraphs = file('DeleteResults.txt')

checkedBad = set()
checkedGood = set()

def deleteVertices(G, tab, First):
    graph6 = G.graph6_string()
    print tab*" " + "Checking Graph: " + graph6 + " on {} vertices".format(G.order())
    found = False
    if graph6 in checkedGood:
        found = True
    if (graph6 not in checkedBad) and (First or found or check(G)):
        checkedGood.add(graph6)
        output_file.write(tab*" " + G.graph6_string() + "\n")
        print tab*" " + G.graph6_string() + " has a non-tight bound ************"
        if G.is_vertex_transitive():
            H = G.copy()
            H.delete_vertex(G.order()-1)
            H = H.canonical_label()
            deleteVertices(H,tab+4,False)
        else:
            for v in range(G.order()):
                H = G.copy()
                H.delete_vertex(v)
                H = H.canonical_label()
                deleteVertices(H,tab+4,False)
    else:
        checkedBad.add(graph6)
        graphs_checked.write(graph6 + "\n")

