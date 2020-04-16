import os
from collections import Counter

def createSummary(workingDirectory):
    os.chdir(workingDirectory)
    maxDepth = len(os.listdir("_completed_smooth_solutions"))
    # currentDepths = [int(s.split("_")[1]) for s in \
    #     os.listdir("_completed_smooth_solutions")]
    # currentDepths.sort()
    solsAtDepth = \
    [os.listdir("_completed_smooth_solutions/depth_"+str(depth))\
      for depth in range(maxDepth)]

    currentDisplay =""

    fullDepthDims = []
    for s in solsAtDepth[-1]:
        if "tracking" in s:
           fullDepthDims.append(s.split("dim")[1].split("varGroup")[0])
        else:
           fullDepthDims.append(s.split("dim")[1].split("pointId")[0])

    numberVarGroups = len(fullDepthDims[0].split("_")[1:-1])
    header = """
----------------------------------------------------------------
| # smooth isolated solutions  | # of general linear equations |
| found                        | added with variables in group |
----------------------------------------------------------------
                               | %s
----------------------------------------------------------------
"""%("  ".join([str(i) for i in range(numberVarGroups)]))


    currentMultidegreeBound = Counter(fullDepthDims)
    currentSolutions = {}
    for fileName in solsAtDepth[-1]:
        f = open("_completed_smooth_solutions/depth_"+ str(maxDepth-1) 
            +"/" + fileName, "r")
        fileText = f.read()
        f.close()

        dim = ""
        if "tracking" in fileName:
           dim = (fileName.split("dim")[1].split("varGroup")[0])
        else:
           dim = (fileName.split("dim")[1].split("pointId")[0])
        if not dim in currentSolutions.keys():
            currentSolutions[dim] = []
        currentSolutions[dim].append(fileText)

    for d in currentMultidegreeBound.keys():
      dimension = d.split("_")[1:-1]
      # if all([i=="0" for i in dimension]):
      #     currentDisplay += \
      #         "Found %d isolated smooth solutions\n"%currentMultidegreeBound[d]
      # else:
      currentDisplay += header
      currentDisplay += "  "\
          + str(currentMultidegreeBound[d])\
          + " "*(31-len(str(currentMultidegreeBound[d])))\
          + "".join([str(i) + " "*(3-len(str(i))) for i in dimension])\
          + "\n"
      for sol in currentSolutions[d]:
        currentDisplay += sol


    summaryFile = open("summary.txt", "w")
    summaryFile.write(currentDisplay)
    summaryFile.close()

createSummary("run")
