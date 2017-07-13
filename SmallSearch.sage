load("check.sage")

def is_alpha_critical(G):
     alpha=len(G.independent_set())
     for i in G.edges():
         H=G.copy()
         H.delete_edge(i)
         if len(H.independent_set())==alpha:
             return False
     return True

output_file = open("Smallest.txt","w")
Tocheck = set()
with open("CheckedBad.txt") as input_file:
    for line in input_file:
        line = line.rstrip()
        g = Graph(line).canonical_label()
        if g.order() == 12:
            print line
            alpha = len(g.independent_set())
            while not is_alpha_critical(g):
                h = g.copy()
                re = g.random_edge()
                h.delete_edge(re)
                if alpha == len(h.independent_set()):
                    g.delete_edge(re)
                    print re
            Tocheck.add(g.canonical_label().graph6_string())

for graphstring in Tocheck:
    graph = Graph(graphstring)
    if check(graph):
        print graphstring + " has a non-tight bound"
        output_file.write(graphstring + "\n")
    else:
        print graphstring + " didn't work"
    



