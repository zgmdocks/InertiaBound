#!/usr/bin/env python
def Clean():
    f = open("Minimal.txt","r")
    read = f.readlines()
    goTo = int(read[0])

    i = 0
    NeedErase = False
    for line in read:
        if i < goTo:
            None
        else:
            if line[0] != " ":
                NeedErase = True
                break
        i += 1

    if NeedErase:
        i = 0
        f = open("Minimal.txt","w")
        Write = False
        for line in read:
            if i < goTo-1:
                f.write(line)
            else:
                if line[0] != " " and i > goTo-1:
                    Write = True
                if Write:
                    f.write(line)
            i += 1

    f.close()

