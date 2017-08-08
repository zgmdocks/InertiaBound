load("check.sage")
def is_alpha_critical(G):
    alpha=len(G.independent_set())
    for i in G.edges():
        H=G.copy()
        H.delete_edge(i)
        if len(H.independent_set())==alpha:
            return False
    return True

output = open("tightsubgraph.txt","a")

with open("GoodGraphs.txt") as input_file:
    for line in input_file:
        g = Graph(line.rstrip())
        print line.rstrip()
        n = g.order()
        for combo in Combinations(n,2):
            if combo[0] in g.neighbors(combo[1]):
                continue
            h = g.copy()
            h.add_edge(combo[0],combo[1])
            print combo
            if not is_alpha_critical(h):
                continue
            print combo
            print h.graph6_string()
            output.write(h.graph6_string())
            print "$#$#$#$#$#$#$#$#$#$#$$$$$$$$$$$$$$$#############$$#$#$#$#$#$#"
            if check(h):
                print "this is non-tight"
            else:
                print "maybe tight"
            break
