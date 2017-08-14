output_file = open("HermWeightings.txt","a")
limit = 500000
with open("11.txt") as input_file:
    t = int(input_file.readline())
    c = 1
    while c < t:
        input_file.readline()
        c += 1
    for line in input_file:
        print line.rstrip()
        g = Graph(line)
        alpha = len(g.independent_set())
        print alpha
        M = g.adjacency_matrix()
        C = Matrix(CDF,M)
        count = 0
        lowest = None
        while min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues())) != alpha  and count < limit:
            count += 1
            for k in range(g.order()):
                for j in range(g.order()):
                    if C[k,j] != 0:
                        C[k,j] = uniform(-10,10) + uniform(-10,10)*i
                        while C[k,j] == 0:
                            C[k,j] = uniform(-10,10)*10 + uniform(-10,10)*i
                        C[j,k] = conjugate(C[k,j])
            if not C.is_hermitian():
                print "C is not hermitian"
                print C
                break
            minEig = min(sum(real(x)>=0 for x in C.eigenvalues()), sum(real(x)<=0 for x in C.eigenvalues()))
            if lowest == None:
                lowest = minEig
            else:
                if minEig < lowest:
                    lowest = minEig
            print count, minEig
        print lowest
        print count
        print C
        if count < limit and C.is_hermitian():
            output_file.write(line)
            output_file.write(C.str())
            output_file.write("\nalpha: {}\neigenvalues: {}\nNon-negative: {}\nNon-positive: {}\n\n".format(alpha,C.eigenvalues(),sum(x>=0 for x in C.eigenvalues()),sum(x<=0 for x in C.eigenvalues())))
        else:
            output_file.write("graph number: " + str(t) + "\n")
            output_file.write(line)
            output_file.write("alpha: {}\nlowest: {}\n\n".format(alpha,lowest))
        output_file.flush()
        t += 1
        firstLine = open('11.txt', "r+")
        firstLine.write(str(t) + "\n")
        firstLine.close()
