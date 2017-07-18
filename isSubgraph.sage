g = Graph("Jtv`plZXy^_")

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

#output = open("Subgraphof19-2.txt","w")

with open("Original19NoCanon.txt") as input_file:
    counter = 0
    for line in input_file:
        counter += 1
        if counter < 0:
            continue
        G = Graph(line.rstrip())
        print line.rstrip()
        if G.subgraph_search(g):
            print True
 #           output.write(line)
        else:
            print False
        


