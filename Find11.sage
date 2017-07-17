load("check.sage")

def is_alpha_critical(G):
     alpha=len(G.independent_set())
     for i in G.edges():
         H=G.copy()
         H.delete_edge(i)
         if len(H.independent_set())==alpha:
             return False
     return True

output_file = open("12.txt","a")
Tocheck = set()
with open("13.txt") as input_file:
    input_file.readline()
    for line in input_file:
        line = line.rstrip()
        g = Graph(line).canonical_label()
        for v in g.vertices():
            h = g.copy()
            h.delete_vertex(v)
            alpha = len(h.independent_set())
            print h.canonical_label().graph6_string()
            while not is_alpha_critical(h):
                c = h.copy()
                re = h.random_edge()
                c.delete_edge(re)
                if alpha == len(c.independent_set()):
                    print re
                    h.delete_edge(re)
            Tocheck.add(h.canonical_label().graph6_string())
print len(Tocheck)

for graphstring in Tocheck:
    graph = Graph(graphstring)
    if check(graph):
        print graphstring + " has a non-tight bound #$#$#$#$#$#$#$#$#$#$$#$#$#$#$"
        output_file.write(graphstring + "\n")
    else:
        print graphstring + " didn't work #$#$#$#$#$#$#$#$$##$#$#$#$#$"
    



