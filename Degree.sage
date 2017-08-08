output_file = open("LowestDegree.txt", "w")

with open("GoodGraphs.txt") as input_file:
    TotalLow = None
    for line in input_file:
        g = Graph(line.rstrip())
        lowest = None
        for v in g.vertex_iterator():
            if lowest == None:
                lowest = g.degree(v)
            elif lowest > g.degree(v):
                lowest = g.degree(v)
        output_file.write(line.rstrip() + " {}\n".format(lowest))
        print "{} {}".format(line.rstrip(), lowest)
        if TotalLow == None:
            TotalLow = lowest
        elif lowest < TotalLow:
            TotalLow = lowest
            print "********** new lowest"
    print "Lowest was {}".format(TotalLow)


