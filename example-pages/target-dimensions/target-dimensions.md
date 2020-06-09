<link rel="stylesheet" href="modest.css">
<style>
pre, code, pre code {
  max-height: 400px;
}
</style>
## Use of `targetDimensions`

Here we demonstrate how to use the user defined variable 
`targetDimensions`. This can be used when we have equations defining a 
variety, but we only care about its multidegree coefficients for certain 
multidimension (or set of multidimensions).

### Defining equations

Consider the multiaffine variety consisting of points $(x,y,z) \in 
\mathbb{C} \times \mathbb{C} \times \mathbb{C}$ defined by the following 
equations.

$$
\begin{align*}
(x^2+y+z)x &= 0\\
(x-2y^2+1)x &= 0
\end{align*}
$$


This variety consists of the union of the hyperplane defined by $x=0$ 
and the curve defined by $x^2 + y + z = 0$ and $x-2y^2+1=0$. Say we are 
only interested in the multidegree coefficient for dimension $(1,0,0)$.


### Input format

There are four files that comprise the input to multiregeneration.py

#### inputFile.py
```python
degrees = [[3,1,1],[2,2,0]]
verbose = 1
targetDimensions = [[1,0,0]]
```
This file contains the multidegrees of the defining equations, as well 
as additional options. The command `verbose=1` tells 
multiregeneration.py to display a progress update.

The list `targetDimensions` tells `multiregeneration.py` which 
multidegree coefficients to compute.

#### bertiniInput_variables
```c
variable_group x;
variable_group y;
variable_group z;
```
#### bertiniInput_equations
```c
function f1,f2;

f1 = (x^2+y+z)*x;
f2 = (x-2*y^2+1)*x;

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
variable_group y;
variable_group z;

Solutions in a 'linearProduct' directory and :
depth >= 0 satisfy f1 = 0
depth >= 1 satisfy f2 = 0

Using start solution
0.012375128466856511 -0.2565814893562042
0.007726719075507038 0.29174180975314745
-0.5237758334060103 -0.8229750067836747

Using dimension linears
l[0][0]
(0.7684130112602223+I*-0.8943161646614766)*(x-(0.012375128466856511+I*-0.2565814893562042))
l[1][0]
(-0.08364213914269092+I*-0.8127546723423045)*(y-(0.007726719075507038+I*0.29174180975314745))
l[2][0]
(-0.895171668247414+I*0.5428194720296333)*(z-(-0.5237758334060103+I*-0.8229750067836747))

Using degree linears
(0.19023108388899512 + I*-0.42030087751400713)*x+(-0.008485692961966551 + I*-0.6228163177304067)
(-0.33844904784657626 + I*-0.6476778791386968)*x+(0.212712203008534 + I*-0.25245836673498756)
(0.9884370402199971 + I*0.5354149235985495)*x+(-0.08966115847968115 + I*-0.14478742072228346)
(-0.21762918109769025 + I*0.013936265274712811)*y+(-0.05717961841828911 + I*-0.7658283809366841)
(-0.07357507192159596 + I*0.6476578451882378)*y+(0.09272913801706562 + I*0.8973111600526467)
(-0.41901114889534186 + I*0.3869228114007077)*z+(0.19066518292861034 + I*-0.40917998780953035)
exploring tree in order depthFirst

################### Starting multiregeneration ####################

PROGRESS
Depth 0: 2
Depth 1: 2

----------------------------------------------------------------
| # smooth isolated solutions  | # of general linear equations |
| found                        | added with variables in group |
----------------------------------------------------------------
                               | 0  1  2
----------------------------------------------------------------
  2                              1  0  0  
Done.
```

### A witness set
While multiregeneration.py is running, it creates a directory called 
`run` where it stores the partial witness set data. This data is 
organized in the folder `run/_completed_smooth_solutions`.
```bash
$ tree run/_completed_smooth_solutions/
run/_completed_smooth_solutions/
├── depth_0
│   ├── solution_tracking_depth_0_gens_1_dim_1_0_1_varGroup_2_regenLinear_0_pointId_261562148744_467834493564
│   └── solution_tracking_depth_0_gens_1_dim_1_1_0_varGroup_2_regenLinear_0_pointId_261562148744_699550604641
└── depth_1
    ├── solution_tracking_depth_1_gens_1_1_dim_1_0_0_varGroup_2_regenLinear_0_pointId_699550604641_304186546591
    └── solution_tracking_depth_1_gens_1_1_dim_1_0_0_varGroup_2_regenLinear_0_pointId_699550604641_561923727441

2 directories, 4 files
```

The folder `depth_1` contains the point of intersection of 
the variety in this example and the 
linear equations `l[1][0]` and `l[2][0]`, which are given by
```
l[1][0]
(-0.08364213914269092+I*-0.8127546723423045)*(y-(0.007726719075507038+I*0.29174180975314745))
l[2][0]
(-0.895171668247414+I*0.5428194720296333)*(z-(-0.5237758334060103+I*-0.8229750067836747))
```
These points are the following.
```bash 
$ cat run/_completed_smooth_solutions/depth_0/*

1.237512846685652e-02 -2.565814893562041e-01
5.894567502816868e-01 8.293254645696755e-01
-5.237758334060102e-01 -8.229750067836747e-01

1.237512846685652e-02 -2.565814893562041e-01
7.726719075507094e-03 2.917418097531476e-01
5.795419780016971e-02 -2.853913519671465e-01
```