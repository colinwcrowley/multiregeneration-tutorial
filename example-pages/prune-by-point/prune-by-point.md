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
def pruneByPoint(coordinates):
    # If x-y is satisfied to within a 
    # tolerance of 1e-16, then the point will lie on the 'extra' 
    # component, and should be pruned.

    if abs(coordinates[0] - coordinates[1]) < 1e-10:
      return True
    else:
      return False
```
This file contains the multidegrees of the defining equations, as well 
as additional options. The command `verbose=1` tells 
multiregeneration.py to display a progress update.

The method prune by point is define by the user. It returns `True` if 
the given point lies on an unwanted component, and `False` otherwise. The 
argument `coordinates` is a list of complex numbers representing the 
coordinates of a point. (The coordinates are not separated into variable 
groups.)

In this example, a point is ignored if it satisfies $x-y$ to within a 
tolerance of $10^{-10}$.

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
0.6120927213859351 -0.5869637910452865
-0.8607246497708636 0.7096709843505142
-0.8272084557126054 -0.46936867801462934

Using dimension linears
l[0][0]
(-0.6471602502919691+I*0.5071045647768186)*(x-(0.6120927213859351+I*-0.5869637910452865))+(-0.5309534275405237+I*-0.50087033304964)*(y-(-0.8607246497708636+I*0.7096709843505142))+(0.3772646021684918+I*0.5828629037947555)*(z-(-0.8272084557126054+I*-0.46936867801462934))
l[0][1]
(0.6553319428867708+I*0.6649334627775159)*(x-(0.6120927213859351+I*-0.5869637910452865))+(0.727212309938718+I*-0.01974778671869748)*(y-(-0.8607246497708636+I*0.7096709843505142))+(0.9907994282664152+I*-0.15000758825564686)*(z-(-0.8272084557126054+I*-0.46936867801462934))
l[0][2]
(0.7675992402950649+I*-0.9523561146406823)*(x-(0.6120927213859351+I*-0.5869637910452865))+(-0.812106499408902+I*-0.15019996401193203)*(y-(-0.8607246497708636+I*0.7096709843505142))+(-0.4762638471788807+I*0.6362395115493127)*(z-(-0.8272084557126054+I*-0.46936867801462934))

Using degree linears
(0.7484343864286713 + I*0.20560733080317384)*x+(0.05786272496663569 + I*-0.7297141882194789)*y+(-0.5264264093202347 + I*0.5004725272934674)*z+(-0.09996080108868188 + I*-0.4977578334107029)
(-0.6136894131874964 + I*0.3922392934058119)*x+(-0.3627223102823678 + I*-0.26351112776642216)*y+(-0.8867477648805304 + I*-0.46531779773254645)*z+(0.25293373596067803 + I*0.482756340542549)
(0.9593195816133797 + I*0.15079789618455264)*x+(0.41571519810905455 + I*-0.34399114180762447)*y+(0.5322858829208867 + I*0.918933498830794)*z+(-0.9519440019221193 + I*0.5761361010052006)
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
    ├── solution_tracking_depth_0_gens_1_dim_2_varGroup_0_regenLinear_2_pointId_164244926985_420259138669
    └── solution_tracking_depth_0_gens_1_dim_2_varGroup_0_regenLinear_2_pointId_164244926985_467325455839

1 directory, 2 files
```

The folder `depth_0` contains the two point on intersection of 
$x^2+y^2+z^2 = 0$ and the 
linear equation `l[0][0]`, which is given by
```
(-0.6471602502919691+I*0.5071045647768186)*(x-(0.6120927213859351+I*-0.5869637910452865))+(-0.5309534275405237+I*-0.50087033304964)*(y-(-0.8607246497708636+I*0.7096709843505142))+(0.3772646021684918+I*0.5828629037947555)*(z-(-0.8272084557126054+I*-0.46936867801462934))
```
The two points are the following.
```bash 
$ cat run/_completed_smooth_solutions/depth_0/*

1.118119938371418e+00 1.000657557857476e+00
-1.346697422340464e+00 3.867478121940165e-01
4.142097786351300e-01 -1.443768148389819e+00

-7.993693379292369e-01 -5.015364124123406e-01
-4.938099911246115e-01 3.771925837430750e-01
-2.843431885126573e-01 7.549024283993541e-01
```
