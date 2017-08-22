output_file = open("AddedWeighting.txt","a")
limit = 25000
with open("TryWeighting.txt") as input_file:
    t = int(input_file.readline())
    c = 1
    while c < t:
        input_file.readline()
        c += 1
    for line in input_file:
        print i
        print line.rstrip()
        g = Graph(line)
        gAlpha = len(g.independent_set())
        n = g.order()
        tries = 10
        counter = 0
        output_file.write("subgraph of " + line)
        while counter < tries:
            rand = randint(1,10)
            print rand
            addedEdges = 0
            h = g.copy()
            for combo in Combinations(n,2):
                if combo[0] in g.neighbors(combo[1]):
                    continue
                Temp = h.copy()
                if len(h.independent_set()) != len(Temp.independent_set()):
                    continue
                h.add_edge(combo[0],combo[1])
                print combo
                output_file.write("added edge {}-{}\n".format(combo[0],combo[1]))
                addedEdges += 1
                if addedEdges > rand:
                    break
            print "added {} edges".format(addedEdges)
            print h.graph6_string()
            alpha = len(h.independent_set())
            print alpha
            M = h.adjacency_matrix()
            C = Matrix(RDF,M)
            count = 0
            lowest = None
            while min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues())) != alpha  and count < limit:
                count += 1
                for k in range(h.order()):
                    for j in range(h.order()):
                        if C[k,j] != 0:
                            C[k,j] = uniform(-10,10)
                            while C[k,j] == 0:
                                C[k,j] = uniform(-10,10)
                            C[j,k] = C[k,j]
                minEig = min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues()))
                if lowest == None:
                    lowest = minEig
                else:
                    if minEig < lowest:
                        lowest = minEig
                print count, minEig
            print lowest
            print count
            print C
            if count < limit:
                output_file.write(h.graph6_string() + "\n")
                output_file.write("added {} edges\n".format(addedEdges))
                output_file.write(C.str())
                output_file.write("\nalpha: {}\neigenvalues: {}\nNon-negative: {}\nNon-positive: {}\n\n".format(alpha,C.eigenvalues(),sum(x>=0 for x in C.eigenvalues()),sum(x<=0 for x in C.eigenvalues())))
            else:
                output_file.write("graph number: " + str(t) + "\n")
                output_file.write(h.graph6_string() + "\n")
                output_file.write("added {} edges\n".format(addedEdges))
                output_file.write("alpha: {}\nlowest: {}\n\n".format(alpha,lowest))
            counter += 1
        t += 1
        firstLine = open('TryWeighting.txt', "r+")
        firstLine.write(str(t) + "\n")
        firstLine.close()
