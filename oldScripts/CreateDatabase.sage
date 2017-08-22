goodGraphs = {}
files = ["11.txt","12.txt","13.txt","14.txt","GoodGraphs.txt","original19NoCanon.txt"]

for txt in files:
    with open(txt) as input_file:
        for line in input_file:
            goodGraphs[line.rstrip()] = txt
    print txt
    print len(goodGraphs)

with open("DeleteResults.txt") as input_file:
    input_file.readline()
    input_file.readline()
    for line in input_file:
        goodGraphs[line.lstrip().split(" ")[0].rstrip()] = "DR"

print len(goodGraphs)
output = open("NonTightGraphs.txt","w")

for size in range(10,30):
    for g6 in goodGraphs.keys():
        g = Graph(g6)
        if g.order() == size:
            output.write(g6 + "\n")
            del goodGraphs[g6]
    print size

