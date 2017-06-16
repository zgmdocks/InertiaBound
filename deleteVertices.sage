load("check.sage")
output_file = open('DeleteResults.txt','a+')

checked = set()
def deleteVertices(G, tab, First):
    graph6 = G.graph6_string()
    print tab*" " + "Checking Graph: " + graph6 + " on {} vertices".format(G.order())
    if graph6 in checked:
        return
    checked.add(graph6)
    found = False
    allGraphs = file('DeleteResults.txt')
    for line in allGraphs:
        if graph6 in line:
            found = True
    if First or found or check(G):
        output_file.write(tab*" " + G.graph6_string() + "\n")
        print tab*" " + G.graph6_string() + " has a non-tight bound ************"
        if G.is_regular():
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

