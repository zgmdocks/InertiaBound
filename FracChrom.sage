output_file = open("fracChrom.txt","a")

with open("GoodGraphs.txt") as input_file:
    i = 0
    for line in input_file:
        i += 1
        if i %100 == 0:
            print i
        g = Graph(line.rstrip())
        clique = g.clique_number()
        adjMatrix = g.adjacency_matrix()
        posEigen = sum(x>0.00001 for x in adjMatrix.eigenvalues())
        negEigen = sum(x<-0.00001 for x in adjMatrix.eigenvalues())
        bound = 1 + max(posEigen/negEigen, negEigen/posEigen)
        if clique < bound:
            output_file.write(line)
            print line.rstrip()

