load('check.sage')
output_file = open('Verify.txt','a+')
for i in range(11,12):
    count = 0
    output_file.write("Graphs on {} vertices:".format(i))
    output_file.write("\n")
    for G in graphs(i):
        count += 1
        print "graph {} on {} vertices".format(count,i)
        if not G.is_connected():
            print "Not Connected"
            continue
        if (check(G)):
            print "{} does not have a tight bound".format(G.graph6_string())
            output_file.write(G.graph6_string())
            output_file.write("\n")
    output_file.write("{} graphs on {} vertices\n".format(count,i))
