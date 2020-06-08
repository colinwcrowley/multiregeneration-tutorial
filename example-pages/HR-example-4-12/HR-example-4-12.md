<link rel="stylesheet" href="modest.css">
<style>
pre, code, pre code {
  max-height: 400px;
}
</style>
## An example in $\mathbb{P}^2 \times \mathbb{P}^2$.

This example of multiregeneration is discusses as example 4.12 in [this 
paper](https://arxiv.org/abs/1507.07069).

### Defining equations

Consider the multiprojective variety consisting of points $[x_0:x_1:x_2] 
\times [y_0:y_1:y_2] \in \mathbb{P}^2 \times \mathbb{P}^2$ defined by 
the following equations.

$$
\begin{align*}
G_1 &= x_0y_2 - x_2y_1 = 0\\
G_2 &= x_1y_2 - x_2y_1 = 0\\
G_3 &= x_0y_1y_2 - x_1y_0y_2 = 0.
\end{align*}
$$

This variety consists of the union of the following four irreducible 
components:

 - $\mathcal{S_1} = \{[x_0:x_1:x_1] \times [1:0:0]\}$ having 
   multidimension $(2,0)$ with multidegree coefficient $1$.
 - $\mathcal{S_2} = \{[x_0:x_1:0] \times [y_0:y_1:0]\}$ having 
   multidimension $(1,1)$ with multidegree coefficient $1$.
 - $\mathcal{C_1} = \{[x_0:x_1:x_2] \times [y_0:y_1:y_2]\}$ having 
   multidimension $(1,0)$ and $(0,1)$ with multidegree coefficients $1$ 
   and $1$ respectively.
 - $\mathcal{C_2} = \{[0:0:1] \times [y_0:0:y_2]\}$ having 
   multidimension $(0,1)$ with multidegree coefficient $1$.

When we run `multiregeneration.py` we will see this information 
reflected in witness set.


### Input format

There are four files that comprise the input to multiregeneration.py

#### inputFile.py
```python
degrees = [[1,1],[1,1],[1,2]]
verbose = 1
```
This file contains the multidegrees of the defining equations, as well 
as additional options. The command `verbose=1` tells 
multiregeneration.py to display a progress update.

#### bertiniInput_variables
```c
hom_variable_group x0, x1, x2;
hom_variable_group y0, y1, y2;
```
#### bertiniInput_equations
```c
function f1,f2,f3;

f1 = x0*y2 - x2*y1;
f2 = x1*y2 - x2*y1;
f3 = x0*y1*y2 - x1*y0*y2;
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
hom_variable_group x0, x1, x2;
hom_variable_group y0, y1, y2;

Solutions in a 'linearProduct' directory and :
depth >= 0 satisfy f1 = 0
depth >= 1 satisfy f2 = 0
depth >= 2 satisfy f3 = 0

Using start solution
-0.8749338308503931 0.16717668108666883
0.5984584523898129 -0.9570739354617974
0.5391417942550696 -0.10888092532493299
0.9932304913992482 0.01052347171019452
-0.6718369239380377 0.6588427274942785
-0.3845297649873347 0.5862605017103801

Using dimension linears
l[0][0]
(0.5582608860709224+I*-0.7796688378627421)*((0.5391417942550696+I*-0.10888092532493299)*x0-(-0.8749338308503931+I*0.16717668108666883)*x2)+(-0.18472564929101698+I*0.7456454889007333)*((0.5391417942550696+I*-0.10888092532493299)*x1-(0.5984584523898129+I*-0.9570739354617974)*x2)
l[0][1]
(0.9809665651137622+I*0.6029865545238269)*((0.5391417942550696+I*-0.10888092532493299)*x0-(-0.8749338308503931+I*0.16717668108666883)*x2)+(0.7395469698280754+I*-0.9406140867043447)*((0.5391417942550696+I*-0.10888092532493299)*x1-(0.5984584523898129+I*-0.9570739354617974)*x2)
l[1][0]
(0.33445398317098585+I*-0.8995427487070253)*((-0.3845297649873347+I*0.5862605017103801)*y0-(0.9932304913992482+I*0.01052347171019452)*y2)+(-0.6435543621776758+I*0.28509213903864294)*((-0.3845297649873347+I*0.5862605017103801)*y1-(-0.6718369239380377+I*0.6588427274942785)*y2)
l[1][1]
(0.8598334945161197+I*-0.27342777460068945)*((-0.3845297649873347+I*0.5862605017103801)*y0-(0.9932304913992482+I*0.01052347171019452)*y2)+(0.18833165049122114+I*-0.2562398921624629)*((-0.3845297649873347+I*0.5862605017103801)*y1-(-0.6718369239380377+I*0.6588427274942785)*y2)

Using degree linears
(0.4262464708517326 + I*0.17774639967152805)*x0+(-0.2692691273654415 + I*-0.3580756760571744)*x1+(-0.38817730910894443 + I*0.7553437494349051)*x2
(0.6211028548342328 + I*0.03736944293550404)*y0+(0.45998072953982594 + I*0.5390829841861211)*y1+(0.8289825494097245 + I*-0.0916779408617765)*y2
(-0.3210896019473253 + I*0.4597119905247675)*y0+(0.9779394387779623 + I*0.5071703555580802)*y1+(0.9598541605005511 + I*-0.7207719111384725)*y2
exploring tree in order depthFirst

################### Starting multiregeneration ####################

PROGRESS
Depth 0: 2
Depth 1: 4
Depth 2: 5

----------------------------------------------------------------
| # smooth isolated solutions  | # of general linear equations |
| found                        | added with variables in group |
----------------------------------------------------------------
                               | 0  1
----------------------------------------------------------------
  1                              1  1  
  2                              0  1  
  1                              2  0  
  1                              1  0  
Done.
```
Adding up the multidegree coefficients, we see that all irreducible 
components $\mathcal{S_1}, \mathcal{S_2}, \mathcal{C_1},$ and 
$\mathcal{C_2}$ are accounted for. Note that `multiregeneration.py` does 
not identify irreducible components.
### A witness set
While multiregeneration.py is running, it creates a directory called 
`run` where it stores the partial witness set data. This data is 
organized in the folder `run/_completed_smooth_solutions`.
```bash
$ tree run/_completed_smooth_solutions/
run/_completed_smooth_solutions/
├── depth_0
│   ├── solution_tracking_depth_0_gens_1_dim_1_2_varGroup_1_regenLinear_2_pointId_54792792578_658233741551
│   └── solution_tracking_depth_0_gens_1_dim_2_1_varGroup_1_regenLinear_2_pointId_54792792578_874712251131
├── depth_1
│   ├── solution_tracking_depth_1_gens_1_1_dim_0_2_varGroup_1_regenLinear_2_pointId_658233741551_657024184119
│   ├── solution_tracking_depth_1_gens_1_1_dim_1_1_varGroup_1_regenLinear_2_pointId_658233741551_739471123422
│   ├── solution_tracking_depth_1_gens_1_1_dim_1_1_varGroup_1_regenLinear_2_pointId_874712251131_189644992126
│   └── solution_tracking_depth_1_gens_1_1_dim_2_0_varGroup_1_regenLinear_2_pointId_874712251131_70371161626
└── depth_2
    ├── solution_tracking_depth_2_gens_1_1_1_dim_0_1_varGroup_1_regenLinear_2_pointId_189644992126_612394311054
    ├── solution_tracking_depth_2_gens_1_1_1_dim_0_1_varGroup_1_regenLinear_2_pointId_657024184119_706648938111
    ├── solution_tracking_depth_2_gens_1_1_1_dim_1_0_varGroup_1_regenLinear_2_pointId_189644992126_186449096001
    ├── solution_vanishing_depth_2_gens_1_1_0_dim_1_1_pointId_739471123422_739471123422
    └── solution_vanishing_depth_2_gens_1_1_0_dim_2_0_pointId_70371161626_70371161626

3 directories, 11 files
```

The folder `depth_2` contains the data of a witness set collection 
(minus the grouping of points into irreducible components). The points 
are
```bash
$cat run/_completed_smooth_solutions/depth_2/*

1.000000000000000e+00 0.000000000000000e+00
1.000000000000000e+00 5.551115123125783e-17
7.583821587337987e-02 2.887010955659847e-01
9.999999999999993e-01 -7.771561172376096e-16
1.000000000000000e+00 0.000000000000000e+00
7.583821587337944e-02 2.887010955659832e-01

-1.865163179455280e-18 -4.221641138321444e-18
-1.867690832218763e-18 -4.137835109850937e-18
1.000000000000000e+00 0.000000000000000e+00
1.000000000000000e+00 0.000000000000000e+00
5.691628885645588e-20 -5.529855027656015e-20
-2.230540059229236e-01 3.517244336082421e-01

1.000000000000000e+00 0.000000000000000e+00
9.999999999999999e-01 0.000000000000000e+00
-1.691689138817545e-02 -1.443156269975638e-01
9.999999999999994e-01 1.387778780781446e-16
1.000000000000000e+00 0.000000000000000e+00
-1.691689138817542e-02 -1.443156269975638e-01

7.443750287841593e-01 -2.960613566137319e-01
1.000000000000000e+00 0.000000000000000e+00
5.108189102009351e-16 -4.466354536175710e-16
5.121315201929852e-01 5.250111081663935e-01
1.000000000000000e+00 0.000000000000000e+00
4.295173654124313e-16 -3.951820438633320e-16

-5.365268815923644e-01 -5.786854736148036e-01
1.000000000000000e+00 0.000000000000000e+00
3.350181628365055e-01 3.538361358028788e-01
1.000000000000000e+00 0.000000000000000e+00
1.256077483161474e-16 -5.218590840865388e-17
-7.715775863807838e-17 3.305979645270316e-17
```
and the linear equations that are added to $G_1,G_2,G_3$ to obtain these 
points are given as the `l[i][j]` in the output above.
