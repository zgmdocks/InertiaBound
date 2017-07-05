output_file = open("replace.txt","w")
output_file.write("Original Graph6 String:                           Canonical Label:\n")
with open("original19.txt") as input_file:
    for line in input_file:
        graph = line.rstrip()
        space = 50 - len(graph)
        output_file.write("{}{}{}\n".format(graph,space*" ",Graph(graph).canonical_label().graph6_string()))
        
