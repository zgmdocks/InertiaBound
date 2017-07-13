g = Graph("Jtv`plZXy^_")

def isomorphic_subgraph(orig,subgraph):
    checked = set()
    size = subgraph.order()
    numVertices = orig.order()
    count = 0
    for combo in Combinations(numVertices,size):
        count += 1
        I = G.subgraph(combo,immutable=true)
        if I in checked:
            continue
        if I.is_isomorphic(subgraph):
            return True
    print count
    return False

output = open("Subgraphof19.txt","w")

with open("Original19NoCanon.txt") as input_file:
    for line in input_file:
        G = Graph(line.rstrip())
        print line.rstrip()
        if isomorphic_subgraph(G,g):
            print True
            output.write(line)
        else:
            print False
        


