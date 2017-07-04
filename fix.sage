k = 3

output_file = open("fixed.txt",'w')

graphs = {}

with open("DeleteResults.txt") as input_file:
    output_file.write(input_file.readline())
    output_file.write(input_file.readline())
    for line in input_file:
        words = line.lstrip().rstrip().split(" ")
        space = len(line) - len(line.lstrip())
        if len(words) == 2:
            if graphs[words[0]] != int(words[1]):
                output_file.write(space*" " + words[0] + " {}\n".format(graphs[words[0]]))
            else:
                output_file.write(line)
        else:
            if words[0] not in graphs:
                graphs[words[0]] = k
                output_file.write(line)
            else:
                output_file.write(space*" " + words[0] + " {}\n".format(graphs[words[0]]))
        graphs[words[0]] = k
        k += 1
print len(graphs)
