load("check.sage")

def is_alpha_critical(G):
     alpha=len(G.independent_set())
     for i in G.edges():
         H=G.copy()
         H.delete_edge(i)
         if len(H.independent_set())==alpha:
             return False
     return True

output_file = open("EdgesResults.txt","a")
Tocheck = set()

inter = True
if inter == False:
    intermediate = open("intermediate.txt","w")

if inter == False:
    with open("CheckedBad.txt") as input_file:
        for line in input_file:
            line = line.rstrip()
            g = Graph(line).canonical_label()
            if g.order() != 14:
                continue
            for v in g.vertices():
                h = g.copy()
                h.delete_vertex(v)
                alpha = len(h.independent_set())
                print h.canonical_label().graph6_string()
                count = 0
                while not is_alpha_critical(h):
                    count += 1
                    if count % 100 == 0:
                        print count
                    if count > 1000:
                        break
                    c = h.copy()
                    re = h.random_edge()
                    c.delete_edge(re)
                    if alpha == len(c.independent_set()) and c.is_connected():
                        print re
                        h.delete_edge(re)
                intermediate.write(h.canonical_label().graph6_string() + "\n")
                Tocheck.add(h.canonical_label().graph6_string())

NoGood = set()
Good = set()

if inter:
    with open("intermediate.txt") as input_file:
        for line in input_file:
            Tocheck.add(line.rstrip())

    with open("NoGood.txt") as input_file:
        for line in input_file:
            NoGood.add(line.rstrip())

    with open("EdgesResults.txt") as input_file:
        for line in input_file:
            Good.add(line.rstrip())
            Tocheck.add(line.rstrip())

print len(Tocheck)
print len(NoGood)
Tocheck = Tocheck.symmetric_difference(NoGood)
print len(Tocheck)
print len(Good)
Tocheck = Tocheck.symmetric_difference(Good)
print len(Tocheck)

if inter == False:
    intermediate.flush()
print len(Tocheck)

NoGoodFile = open("NoGood.txt","a")


num = 12
while len(Tocheck) > 0:
    print ""
    print num
    print ""
    num -= 1
    NonTight = set()
    for graphstring in Tocheck:
        graph = Graph(graphstring)
        if check(graph):
            print graphstring + " has a non-tight bound #$#$#$#$#$#$#$#$#$#$$#$#$#$#$"
            output_file.write(graphstring + "\n")
            output_file.flush()
            NonTight.add(graphstring)
        else:
            print graphstring + " didn't work #$#$#$#$#$#$#$#$$##$#$#$#$#$"
            NoGoodFile.write(graphstring + "\n")
            NoGoodFile.flush()
    Tocheck = set()
    for line in NonTight:
        line = line.rstrip()
        g = Graph(line).canonical_label()
        for v in g.vertices():
            h = g.copy()
            h.delete_vertex(v)
            alpha = len(h.independent_set())
            print h.canonical_label().graph6_string()
            count = 0
            while not is_alpha_critical(h):
                count += 1
                if count % 100 == 0:
                    print count
                if count > 1000:
                    break
                c = h.copy()
                re = h.random_edge()
                c.delete_edge(re)
                if alpha == len(c.independent_set()) and c.is_connected():
                    print re
                    h.delete_edge(re)
            Tocheck.add(h.canonical_label().graph6_string())
    print len(Tocheck)

       



