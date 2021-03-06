# ctpPOP2
- ctpPOP2 is a Windows version for [ctpPOP](https://github.com/maihoanganh/ctpPOP) to solve polynomial optimization problem (POP):

**inf_{x in R^n} { f(x) : gi(x) = 0, hj(x) = 0 },**

with some special cases of inequality constraints **gi**:

Case 1: Annulus constraints on subsets of variables: **Ui >= ||x(Ti)||^2 >= Li**.

Case 2: Simlex constraints: **xi >= 0, 1 - x1 -...- xn >= 0**.

- The main idea of ctpPOP is to solve the Moment-SOS relaxation of the form:

**v = inf_X { <C,X> : X is psd, AX = b },**

which has constant trace property (CTP):

**AX = b => trace(X) = a,**

by using Conditional gradient-based augmented Lagrangian (CGAL).

- Although possibly slower than the other method on the sparse POPs, ctpPOP is much more robust on the dense ones.

- ctpPOP combines CTP with term sparity (TS), correlative sparsity (CS) and correlative sparsity-term sparsity (CS-TS) to avoid memory issue of the large-scale SDP relaxations for POPs.


# Required softwares
ctpPOP has been implemented on a desktop compute with the following softwares:
- Ubuntu 18.04.4
- Julia 1.3.1

The following sofwares are used for comparison purposes:
- [Mosek 9.1](https://www.mosek.com)
- [COSMO](https://github.com/oxfordcontrol/COSMO.jl)

Before installing ctpPOP, you should install [TSSOS](https://github.com/wangjie212/TSSOS) and [PolyPowerModels](https://github.com/tweisser/PolyPowerModels) with the following commands:
```ruby
Pkg> add https://github.com/wangjie212/TSSOS
Pkg> add https://github.com/tweisser/PolyPowerModels.git
```

# Installation
- To use ctpPOP in Julia, run
```ruby
Pkg> add https://github.com/maihoanganh/ctpPOP2.git
```

# Remark
- LMBM solver is not supported in this version.
# Usage
The following examples briefly guide to use ctpPOP:

## Polynomial optimization
Consider the following POP on the unit ball:
```ruby
using DynamicPolynomials

@polyvar x[1:2] # variables

f=x[1]^2+0.5*x[1]*x[2]-0.25*x[2]^2+0.75*x[1]-0.3*x[2] # the objective polynomial to minimize

g=[1.0-sum(x.^2)] # the inequality constraints
h=[(x[1]-1.0)*x[2]] # the equality constraints

k=2 # relaxation order

using ctpPOP2

# get information from the input data f,gi,hj
n,m,l,lmon_g,supp_g,coe_g,lmon_h,supp_h,coe_h,lmon_f,supp_f,coe_f,dg,dh=ctpPOP2.get_info(x,f,g,h,sparse=false);

# get the optimal value of the Moment-SOS relaxation of order k
opt_val=ctpPOP2.POP_dense_CGAL(  n, # the number of variables
                                m, # the number of the inequality constraints
                                l, # the number of the equality constraints
                                lmon_g, # the number of terms in each inequality constraint
                                supp_g, # the support of each inequality constraint
                                coe_g, # the coefficients of each inequality constraint
                                lmon_h, # the number of terms in each equality constraint
                                supp_h, # the support of each equality constraint
                                coe_h, # the coefficients of each equality constraint
                                lmon_f, # the number of terms in the objective polynomial
                                supp_f, # the support of the objective polynomial
                                coe_f, # the coefficients of the objective polynomial
                                dg, # the degree of each inequality constraint
                                dh, # the degree of each equality constraint
                                k,
                                maxit=Int64(1e6), # the maximal iteration of CGAL solver
                                tol=1e-3, # the tolerance of CGAL solver
                                use_eqcons_to_get_constant_trace=false, # use the equality constraints to get constant trace
                                check_tol_each_iter=true ) # check the tolerance at each iteration
```

See other examples in the [link](https://github.com/maihoanganh/ctpPOP2/tree/main/examples).


# References
For more details, please refer to:

**N. H. A. Mai, J.-B. Lasserre, V. Magron and J. Wang. Exploiting constant trace property in large-scale polynomial optimization, 2020. Forthcoming.**
