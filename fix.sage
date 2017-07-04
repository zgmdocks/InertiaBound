k = 2

output_file = open("fixed.txt",'w')

graphs = {}

with open("DeleteResults.txt") as input_file:
    input_file.readline()
    input_file.readline()
    for line in input_file:
        words = line.lstrip().rstrip().split(" ")
        if len(words) == 2:
            if graphs[words[0]] != words[1]:
                output_file.write(line.rstrip() + " ************** last seen = {}".format(graphs[word[0]]))
            else:
                output_file.write(line)
        else:
            if word[0] not in graphs:
                graphs[word[0]] = k
                output_file.write(line)
            else:
                output_file.write(line.rstrip() + " ************* last seen = {}".format(graphs[word[0]]))
        graphs[word[0]] = k

