degrees = [[3]]
verbose = 1
def pruneByPoint(bfePrime, i, PPi):
    # The complex coordinates (in variable group 0) of the point PPi
    coordinates = \
        [complex(s.replace(" -","-").replace(" ", "+") +"j") for \
        s in PPi[0]]

    # If either x-y is satisfied to within a 
    # tolerance of 1e-16, then the point will lie on the 'extra' 
    # component, and should be pruned.

    if abs(coordinates[0] - coordinates[1]) < 1e-16:
      return True
    else:
      return False
