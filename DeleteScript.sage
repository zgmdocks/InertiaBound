load('deleteVertices.sage')
i = 0
with open('/Users/zgmdocks/Downloads/Found.txt') as input_file:
    for line in input_file:
        i += 1
        if i < 5:
            continue
        G = Graph(line)
        deleteVertices(G,0)



        
