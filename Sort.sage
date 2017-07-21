thirteen = open("13.txt", "a")
twelve = open("12.txt", "a")
eleven = open("11.txt","a")
fourteen = open("14.txt","a")

with open("EdgesResults.txt") as input_file:
    for line in input_file:
        g = Graph(line.rstrip())
        if g.order() == 14:
            fourteen.write(line)
        elif g.order() == 13:
            thirteen.write(line)
        elif g.order() == 12:
            twelve.write(line)
        elif g.order() == 11:
            eleven.write(line)
        else:
            print "doesn't have a correct order: {}".format(line.rstrip())
