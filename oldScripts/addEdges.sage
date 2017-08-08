load("check.sage")

g = Graph("Jtv`plZXy^_")

def alpha_critical(G):
    alpha=len(G.independent_set())
    for i in G.edges():
        H=G.copy()
        H.delete_edge(i)
        if len(H.independent_set())==alpha:
            print i
            return i
    return True

output_file = open("addResults.txt","a")

while check(g):
    output_file.write(g.graph6_string() + "\n")
    output_file.flush()
    alpha = len(g.independent_set())
    new = g.add_vertex()
    print new
    print alpha
    while len(g.independent_set()) != alpha:
        indSet = g.independent_set()
        print indSet
        indSet.remove(new)
        print g.add_edge(indSet[0],new)
    #g = g.canonical_label()
    print g.independent_set()
    test = alpha_critical(g)
    print test
    print g.graph6_string()
    while test != True:
        g.delete_edge(test)
        test = alpha_critical(g)


print g.independent_set()
print alpha_critical(g)
print check(g)
print g.canonical_label().graph6_string()
