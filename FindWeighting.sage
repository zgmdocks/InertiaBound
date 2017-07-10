g = Graph("L\U[{|y^NF[jR~")
alpha = len(g.independent_set())
print alpha
M = g.adjacency_matrix()
C = copy(M)
count = 0
while min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues())) != alpha  and count < 1000000:
    count += 1
    for i in range(g.order()):
        for j in range(g.order()):
            if C[i,j] != 0:
                C[i,j] = randint(-100,100)
                while C[i,j] == 0:
                    C[i,j] = randint(-100,100)
    print count, min(sum(x>=0 for x in C.eigenvalues()), sum(x<=0 for x in C.eigenvalues()))
print count
print C
