# is_alpha_critical returns true if the graph G is alpha critical
def is_alpha_critical(G):
    alpha=len(G.independent_set())
    for i in G.edges():
        H=G.copy()
        H.delete_edge(i)
        if len(H.independent_set())==alpha:
            return False
    return True

count = 0

output_file = open("AlphaCheck.txt","w")

with open("textFiles/CheckedBad.txt") as input_file:
    for line in input_file:
        g = Graph(line.rstrip())
        Alpha = False
        if is_alpha_critical(g):
            count += 1
            Alpha = True
        output_file.write("{} {} {}\n".format(line.rstrip(), g.order(), Alpha))

output_file.write(str(count))

