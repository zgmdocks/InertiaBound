load("check.sage")
output_file = open('DeleteResults.txt','a+')

checked = set()
def deleteVertices(G, tab, First):
    print tab*" " + "Checking Graph: " + G.graph6_string() + " on {} vertices".format(G.order())
    if G.graph6_string() in checked:
        return
    checked.add(G.graph6_string())
    if First or check(G):
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

