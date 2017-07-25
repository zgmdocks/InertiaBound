output_file = open("GoodGraphs.txt","a")
output = set()
with open("14.txt") as input_file:
    for line in input_file:
        graph6 = line.lstrip().split(" ")[0].rstrip()
        output.add(graph6)

for graph in output:
    output_file.write(graph + "\n")

