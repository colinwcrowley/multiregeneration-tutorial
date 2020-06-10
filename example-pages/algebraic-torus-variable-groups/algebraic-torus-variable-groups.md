<link rel="stylesheet" href="modest.css">
<style>
pre, code, pre code {
  max-height: 400px;
}
</style>
## Use of `algebraicTorusVariableGroups`

#### Authors: [Colin Crowley](https://sites.google.com/view/colincrowley/home), and [Jose Israel Rodriguez](https://www.math.wisc.edu/~jose/)

Here we demonstrate how to use the user defined variable 
`algebraicTorusVariableGroups`. If, in the relevant application, solutions with 
zeros in certain variable *groups* should be ignored, the user may specify 
this and `multiregeneration.py` will save time by not tracking these 
points.

### Defining equations

Consider the multiaffine variety consisting of points $(x,y,z) \in 
\mathbb{C} \times \mathbb{C}^2$ defined by the following equation.

$$
x*y*z = 0
$$

Variable group number zero is $x$, and variable group number one is 
$y,z$.

This variety consists of the union of the three coordinate hyperplanes. 
Say we would like a witness set for all components in which the 
variables $y,z$ are not uniformly zero


### Input format

There are four files that comprise the input to multiregeneration.py

#### inputFile.py
```python
degrees = [[1,2]]
verbose = 1
algebraicTorusVariableGroups = [1]
```
This file contains the multidegrees of the defining equations, as well 
as additional options. The command `verbose=1` tells 
multiregeneration.py to display a progress update.

The list `algebraicTorusVariableGroups` tells `multiregeneration.py` that all 
points with zeros in the second variable group should be thrown away.

#### bertiniInput_variables
```c
variable_group x;
variable_group y,z;
```
#### bertiniInput_equations
```c
function f;

f = x*y*z;
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
variable_group x;
variable_group y,z;

Solutions in a 'linearProduct' directory and :
depth >= 0 satisfy f = 0

Using start solution
0.8972051648666362 -0.39898639680275916
-0.9077031676898859 -0.3943108899739127
-0.7428696303170752 0.3495090812140429

Using dimension linears
l[0][0]
(0.3062182229418371+I*0.482813554170906)*(x-(0.8972051648666362+I*-0.39898639680275916))
l[1][0]
(0.5383822429503189+I*0.2503219791419471)*(y-(-0.9077031676898859+I*-0.3943108899739127))+(-0.07136625067974389+I*0.41584687898265527)*(z-(-0.7428696303170752+I*0.3495090812140429))
l[1][1]
(0.5799231424277893+I*-0.7932545584001651)*(y-(-0.9077031676898859+I*-0.3943108899739127))+(0.24977464415923056+I*-0.5077801479313844)*(z-(-0.7428696303170752+I*0.3495090812140429))

Using degree linears
(0.1464920179273812 + I*-0.6465502281501778)*x+(-0.5072844892586013 + I*-0.5293561596437888)
(-0.8537330553628488 + I*0.30734891050065705)*y+(-0.3196125729586834 + I*-0.031611872298001886)*z+(-0.8962913409195759 + I*-0.9589522119882019)
(0.01635233928502866 + I*0.1209387447477257)*y+(-0.447832569204752 + I*-0.2948052058911983)*z+(0.03416469622921814 + I*-0.6240129128345355)
exploring tree in order depthFirst

################### Starting multiregeneration ####################

PROGRESS
Depth 0: 1

----------------------------------------------------------------
| # smooth isolated solutions  | # of general linear equations |
| found                        | added with variables in group |
----------------------------------------------------------------
                               | 0  1
----------------------------------------------------------------
  1                              0  2  
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
    └── solution_tracking_depth_0_gens_1_dim_0_2_varGroup_1_regenLinear_1_pointId_76815293686_175634001278

1 directory, 1 file
```

The folder `depth_0` contains the point of intersection of 
$x = 0$ and the 
linear equation `l[1][0]`, which is given by
```
(0.5383822429503189+I*0.2503219791419471)*(y-(-0.9077031676898859+I*-0.3943108899739127))+(-0.07136625067974389+I*0.41584687898265527)*(z-(-0.7428696303170752+I*0.3495090812140429))
```
This point is the following.
```bash 
$ cat run/_completed_smooth_solutions/depth_0/*

-4.048696831470263e-16 8.173382666818587e-16
-9.077031676898859e-01 -3.943108899739126e-01
-7.428696303170752e-01 3.495090812140431e-01
```
