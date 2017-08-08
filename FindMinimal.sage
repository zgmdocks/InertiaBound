import cleanFunc
i = 0
k = 2
read_graphs = open('CheckedBad.txt','r')
load("check.sage")
output_file = open('Minimal.txt','a+')
graphs_checked = open('CheckedBad.txt','a+')
allGraphs = file('GoodGraphs.txt')
GoodGraphs = file('GoodGraphs.txt','a')

alreadySeen = set()

checkedBad = set()
# this dictionary has the keys be the graph6 string of graphs that ended up having
# a non-tight bound. The value is the last line that this graph was written on in
# the file DeleteResults. This is useful because we want to know if two graphs
# have an intersection of non-tight subgraphs but we don't want to rewrite the
# same thing multiple times or else the file will get huge. This we we see if
# two graphs share a subgraph without repetitively written the same thing.
checkedGood = set()

PartiallyChecked = set()
FoundFromMinimal = set()

def is_alpha_critical(G):
     alpha=len(G.independent_set())
     for i in G.edges():
         H=G.copy()
         H.delete_edge(i)
         if len(H.independent_set())==alpha:
             return False
     return True
SeenLastGraph = False
def deleteVertices(G, tab, First):
    global k
    global SeenLastGraph
    count = 0
    alpha = len(G.independent_set())
    Changed = True
    while not is_alpha_critical(G) and Changed == True:
        Changed = False
        for e in G.edges():
            c = G.copy()
            c.delete_edge(e)
            if alpha == len(c.independent_set()) and c.is_connected():
                print tab*" " + str(e)
                G.delete_edge(e)
                Changed = True
                break
    graph6 = G.graph6_string()
    if graph6 in alreadySeen and (graph6 not in checkedBad):
        print "#$#$#$#$#$#$#$ already seen {} #$#$#$#$#$#$#$#$#$#".format(graph6)
        output_file.write(tab*" " + graph6 + "\n")
        output_file.flush()
        return
    alreadySeen.add(graph6)
    print tab*" " + "Checking Graph: " + graph6 + " on {} vertices".format(G.order())
    found = False
    if graph6 in PartiallyChecked:
        found = True
    if graph6 in checkedGood:
        found = True
    if (graph6 not in checkedBad) and (First or found or check(G)):
        if graph6 not in checkedGood:
            checkedGood.add(graph6)
            output_file.write(tab*" " + graph6 + "\n")
            output_file.flush()
            GoodGraphs.write(graph6 + "\n")
            k += 1
        else:
            print tab*" " + "already seen"
            output_file.write(tab*" " + graph6 + "\n")
            output_file.flush()
            k += 1
            if graph6 in FoundFromMinimal:
                print tab*" " + "already seen in Minimal file"
                if SeenLastGraph:
                    return
                if graph6 == LastGraph:
                    SeenLastGraph = True
        print tab*" " + graph6 + " has a non-tight bound ************"
        FoundFromMinimal.add(graph6)
        if G.is_vertex_transitive():
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
    else:
        if graph6 not in checkedBad:
            graphs_checked.write(graph6 + "\n")
        else:
            print tab*" " + "graph in checkedBad"
        checkedBad.add(graph6)

with open("Minimal.txt") as input_file:
    z = 0
    for line in input_file:
        z += 1


with open("Minimal.txt") as input_file:
    p = 0
    for line in input_file:
        p += 1
        if p == 1:
            continue
        if p == 2:
            startAt = int(line.rstrip())
            continue
        if p == z:
            LastGraph = line.lstrip().rstrip()
            break
        FoundFromMinimal.add(line.lstrip().rstrip())

for line in read_graphs:
    checkedBad.add(line[:-1])

for line in allGraphs:
    checkedGood.add(line.rstrip())

with open('WithoutMinimal.txt') as input_file:
    for line in input_file:
        i += 1
        if i <= startAt:
            continue
        G = Graph(line)
        deleteVertices(G,0,True)
        cleanFunc.Clean()
        firstLine = open('Minimal.txt','r+')
        firstLine.write(str(k) + "\n")
        firstLine.write(str(i) + "\n")
        firstLine.close()


