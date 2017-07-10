output_file = open("TightWeightings.txt","a")
limit = 1000000
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
        while min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues())) != alpha  and count < limit:
            count += 1
            for k in range(g.order()):
                for j in range(g.order()):
                    if C[k,j] != 0:
                        C[k,j] = random()*10
                        while C[k,j] == 0:
                            C[k,j] = random*10
                        C[j,k] = C[k,j]
            print count, min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues()))
        print count
        print C
        if count < limit:
            output_file.write(line)
            output_file.write(C.str())
            output_file.write("\nalpha: {}\neigenvalues: {}\nNon-negative: {}\nNon-positive: {}\n\n".format(alpha,C.eigenvalues(),sum(x>=0 for x in C.eigenvalues()),sum(x<=0 for x in C.eigenvalues())))
        t += 1
        firstLine = open('FalseCheckAlpha.txt', "r+")
        firstLine.write(str(t) + "\n")
        firstLine.close()
