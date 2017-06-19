load('deleteVertices.sage')
i = 0
k = 0
read_graphs = open('CheckedBad.txt','r')

for line in read_graphs:
    checkedBad.add(line[:-1])

for line in allGraphs:
    k += 1
    checkedGood.add(line.lstrip()[:-1])

with open('/Users/zgmdocks/Downloads/Found.txt') as input_file:
    for line in input_file:
        i += 1
        G = Graph(line)
        deleteVertices(G,0,True)



        
