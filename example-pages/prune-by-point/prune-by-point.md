<link rel="stylesheet" href="modest.css">
<style>
pre, code, pre code {
  max-height: 400px;
}
</style>
## Saturation using `pruneByPoint`

It is often the case that the solution set to a system of polynomials 
contains many irreducible components, only some of which are of 
interest. We will demonstrate how to saturate out unwanted components 
using the user defined method `pruneByPoint`.

### Defining equations

Consider the variety consisting of points $(x,y,z) \in \mathbb{C}^3$ 
defined by the following equation.

$$
(x-y)(x^2+y^2+z^2) = 0
$$

This variety consists of the union of the quatratic hypersurface $x^2 + 
y^2 + z^2 = 0$ unioned with the hyperplane $x - y = 0$. Say we want a 
witness set for the component $x^2 + y^2 + z^2 = 0$.


### Input format

There are four files that comprise the input to multiregeneration.py

#### inputFile.py
```python
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
```
This file contains the multidegrees of the defining equations, as well 
as additional options. The command `verbose=1` tells 
multiregeneration.py to display a progress update.

The method prune by point is define by the user. It returns `True` if 
the given point lies on an unwanted component, and false otherwise. The 
three arguments are

 - `PPi`, which is a 2D list of strings containing the complex 
  coordinates of the point. The entry $PPi[i][j]$ is a string 
  representing a complex number (e.g. "1.00e-3 3.4e5" represents $0.001 + 34000i$)
  which is the value of the $j$th coordinate in the $i$th variable group.

 - `bfePrime`, which is the multidimension of the irreducible component 
  containing the point at the current stage of regeneration.

 - `i`, which is the variable group to which a random linear equation 
   was last added.

In this example, all that is relevant are the coordinates of the point, 
which are parsed to complex numbers in python, and on which the function 
$x-y$ is evaluated.

#### bertiniInput_variables
```c
variable_group x,y,z;
```
#### bertiniInput_equations
```c
function f;

f = (x-y)*(x^2+y^2+z^2);
```
#### bertiniInput_trackingOptions
```
SecurityLevel:1;
```

### Running multiregeneration.py

Make sure that the four files discussed above are in your currnet 
directory
```bash
$ ls
bertiniInput_equations  bertiniInput_trackingOptions  bertiniInput_variables  inputFile.py
```
and then run multiregeneration.py from this directory using python.
```bash
python /path/to/multiregeneration.py
```
The output will look like the following.
```
################### Setup multiregeneration ####################

These variable groups have been selected:
variable_group x,y,z;

Solutions in a 'linearProduct' directory and :
depth >= 0 satisfy f = 0

Using start solution
-0.6870240286673379 0.6660089339732769
-0.8656065344958435 -0.04970243975978783
0.8300605198699051 0.9500829864796849

Using dimension linears
l[0][0]
(0.17459767167841567+I*-0.8295059700422907)*(x-(-0.6870240286673379+I*0.6660089339732769))+(0.49802620597619995+I*0.5953150510350627)*(y-(-0.8656065344958435+I*-0.04970243975978783))+(0.6719050118710679+I*-0.01415964309729012)*(z-(0.8300605198699051+I*0.9500829864796849))
l[0][1]
(-0.7789199551464714+I*-0.1436513073995127)*(x-(-0.6870240286673379+I*0.6660089339732769))+(0.9669114635688347+I*0.7602874671856612)*(y-(-0.8656065344958435+I*-0.04970243975978783))+(0.7625539604279046+I*-0.1581665949222475)*(z-(0.8300605198699051+I*0.9500829864796849))
l[0][2]
(-0.49171259759195785+I*-0.005702711338215538)*(x-(-0.6870240286673379+I*0.6660089339732769))+(0.36537981588513757+I*-0.8213649606027058)*(y-(-0.8656065344958435+I*-0.04970243975978783))+(-0.6943393378141078+I*0.4532239418536499)*(z-(0.8300605198699051+I*0.9500829864796849))

Using degree linears
(-0.001269658622827352 + I*0.6468715454215546)*x+(0.8803194362352371 + I*0.8712616352555678)*y+(-0.7470207140430898 + I*-0.7445285994358717)*z+(0.7286071812018424 + I*-0.7789590793502306)
(-0.7118445654072061 + I*0.4862315492708391)*x+(-0.3433568322469507 + I*-0.8856323632769099)*y+(0.31196682077961335 + I*-0.3092364275492774)*z+(0.21875481473839198 + I*0.2603257572184263)
(-0.30200880010613895 + I*-0.9728541042075887)*x+(0.7560001567462522 + I*-0.556949347142659)*y+(-0.4628891090325806 + I*-0.1274893752170574)*z+(-0.0997004595581017 + I*0.6094895559538585)
exploring tree in order depthFirst

################### Starting multiregeneration ####################

PROGRESS
Depth 0: 2

----------------------------------------------------------------
| # smooth isolated solutions  | # of general linear equations |
| found                        | added with variables in group |
----------------------------------------------------------------
                               | 0
----------------------------------------------------------------
  2                              2  
Done.
```

### A witness set
While multiregeneration.py is running, it creates a directory called 
`run` where it stores the partial witness set data. This data is 
organized in the folder `run/_completed_smooth_solutions`.
```bash
$ tree run/_completed_smooth_solutions/
run/_completed_smooth_solutions/
└── depth_0
    ├── solution_tracking_depth_0_gens_1_dim_2_varGroup_0_regenLinear_2_pointId_2121420710_300754649198
    └── solution_tracking_depth_0_gens_1_dim_2_varGroup_0_regenLinear_2_pointId_2121420710_931696304632

1 directory, 2 files
```

The folder `depth_0` contains the two point on intersection of 
$x^2+y^2+z^2 = 0$ and the 
linear equation `l[0][0]`, which is given by
```
(0.17459767167841567+I*-0.8295059700422907)*(x-(-0.6870240286673379+I*0.6660089339732769))+(0.49802620597619995+I*0.5953150510350627)*(y-(-0.8656065344958435+I*-0.04970243975978783))+(0.6719050118710679+I*-0.01415964309729012)*(z-(0.8300605198699051+I*0.9500829864796849))
```
The two points are the following.
```bash 
$ cat run/_completed_smooth_solutions/depth_0/*

-6.654356663954833e-01 7.283916116067314e-01
-6.378868198955263e-01 -8.874949007619301e-02
5.475975875118920e-01 7.817522159281911e-01

-6.436718425042774e-01 1.151147494868021e+00
8.344454815171402e-01 7.671024151343057e-02
-8.922269185184641e-01 -7.587203440611088e-01
```
