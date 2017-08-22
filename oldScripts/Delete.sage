import cleanFunc
i = 0
k = 2
read_graphs = open('CheckedBad.txt','r')
load("check.sage")
output_file = open('DeleteResults.txt','a+')
graphs_checked = open('CheckedBad.txt','a+')
allGraphs = file('DeleteResults.txt')

checkedBad = set()
# this dictionary has the keys be the graph6 string of graphs that ended up having
# a non-tight bound. The value is the last line that this graph was written on in
# the file DeleteResults. This is useful because we want to know if two graphs
# have an intersection of non-tight subgraphs but we don't want to rewrite the
# same thing multiple times or else the file will get huge. This we we see if
# two graphs share a subgraph without repetitively written the same thing.
checkedGood = {}

PartiallyChecked = set()



def deleteVertices(G, tab, First):
    global k
    graph6 = G.graph6_string()
    print tab*" " + "Checking Graph: " + graph6 + " on {} vertices".format(G.order())
    found = False
    if graph6 in PartiallyChecked:
        found = True
    if graph6 in checkedGood:
        found = True
    if (graph6 not in checkedBad) and (First or found or check(G)):
        if graph6 not in checkedGood:
            checkedGood[graph6] = k
            output_file.write(tab*" " + G.graph6_string() + "\n")
            output_file.flush()
            k += 1
        else:
            print tab*" " + "last seen: " + str(checkedGood[graph6])
            output_file.write(tab*" " + G.graph6_string() + " " + str(checkedGood[graph6]) + "\n")
            output_file.flush()
            checkedGood[graph6] = k
            k += 1
            return
        print tab*" " + G.graph6_string() + " has a non-tight bound ************"
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
        checkedBad.add(graph6)



for line in read_graphs:
    checkedBad.add(line[:-1])
    
GoTo = int(allGraphs.readline())

startAt = int(allGraphs.readline())

if GoTo == 0:
    k += 1

for line in allGraphs:
    if k == GoTo-1:
        k += 1
        checkedGood[line.lstrip().split(" ")[0].rstrip()] = k
        break
    k += 1
    checkedGood[line.lstrip().split(" ")[0].rstrip()] = k

for line in allGraphs:
    split = line.lstrip().split(" ")
    if len(split) == 1:
        PartiallyChecked.add(split[0][:-1])


with open('/Users/zgmdocks/Downloads/Found.txt') as input_file:
    for line in input_file:
        i += 1
        if i <= startAt:
            continue
        G = Graph(line)
        deleteVertices(G,0,True)
        cleanFunc.Clean()
        firstLine = open('DeleteResults.txt','r+')
        firstLine.write(str(k) + "\n")
        firstLine.write(str(i) + "\n")
        firstLine.close()


