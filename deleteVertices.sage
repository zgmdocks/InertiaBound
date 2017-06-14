load("check.sage")
output_file = open('DeleteResults.txt','a+')

def deleteVertices(G, tab):
    print tab*" " + "Checking Graph: " + G.graph6_string() + " on {} vertices".format(G.order())
    if check(G):
        output_file.write(tab*" " + G.graph6_string() + "\n")
        print tab*" " + G.graph6_string() + " has a non-tight bound ************"
        if G.is_regular():
            H = G.copy()
            H.delete_vertex(G.order()-1)
            deleteVertices(H,tab+4)
        else:
            for v in range(G.order()):
                H = G.copy()
                H.delete_vertex(v)
                H = H.canonical_label()
                deleteVertices(H,tab+4)

