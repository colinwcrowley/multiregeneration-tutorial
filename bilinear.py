import random
n1 = 5
n2 = 5
def randomComplex():
    return "(%f + %f*I)"%(random.uniform(-1,1), random.uniform(-1,1))

header = "function "
for s in range(n1 + n2):
    header += "f%d"%s
    if s < n1 + n2 -1:
        header += ","
header += ";"
print(header)
for s in range(n1+n2):
    f = ""
    for i in range(n1):
        for j in range(n2):
            f = f + "%s*x_%d*y_%d + "%(randomComplex(), i,j)
    for i in range(n1):
        f = f + "%s*x_%d + "%(randomComplex(), i)
    for i in range(n2):
        f = f + "%s*y_%d + "%(randomComplex(), i)
    f = f + randomComplex()
    print("f%d = %s;"%(s,f))
