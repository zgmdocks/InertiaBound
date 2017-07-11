output_file = open("TightWeightings.txt","a")
limit = 500000
with open("FalseCheckAlpha.txt") as input_file:
    t = int(input_file.readline())
    c = 1
    while c < t:
        input_file.readline()
        c += 1
    for line in input_file:
        print i
        print line.rstrip()
        g = Graph(line)
        alpha = len(g.independent_set())
        print alpha
        M = g.adjacency_matrix()
        C = Matrix(RDF,M)
        count = 0
        lowest = None
        while min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues())) != alpha  and count < limit:
            count += 1
            for k in range(g.order()):
                for j in range(g.order()):
                    if C[k,j] != 0:
                        C[k,j] = random()*100
                        while C[k,j] == 0:
                            C[k,j] = random*100
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
            output_file.write(line)
            output_file.write(C.str())
            output_file.write("\nalpha: {}\neigenvalues: {}\nNon-negative: {}\nNon-positive: {}\n\n".format(alpha,C.eigenvalues(),sum(x>=0 for x in C.eigenvalues()),sum(x<=0 for x in C.eigenvalues())))
        else:
            output_file.write("graph number: " + str(t) + "\n")
            output_file.write(line)
            output_file.write("alpha: {}\nlowest: {}\n\n".format(alpha,lowest))
        t += 1
        firstLine = open('FalseCheckAlpha.txt', "r+")
        firstLine.write(str(t) + "\n")
        firstLine.close()
