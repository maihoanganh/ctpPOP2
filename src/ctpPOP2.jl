module ctpPOP2

using DynamicPolynomials, LinearAlgebra, MosekTools, SparseArrays, JuMP, Arpack, SumOfSquares, LightGraphs, PolyPowerModels, TSSOS, COSMO, PowerModels#, Ipopt


# src
#include("./pop_NLP.jl")
include("./pop_opf.jl")

include("./dense_pop/basicfuncs.jl")
include("./dense_pop/pop_dense_SOS.jl")
include("./dense_pop/pop_dense_CGAL.jl")

include("./sparse_pop/CS/basic_func_sparse.jl")
include("./sparse_pop/CS/clique_merge.jl")
include("./sparse_pop/CS/chordal_extension.jl")

include("./sparse_pop/CS/pop_CS_CGAL.jl")
include("./sparse_pop/CS/basic_func_CS_CGAL.jl")
include("./sparse_pop/CS/model_cliq_CS_CGAL.jl")

include("./sparse_pop/TS/pop_TS_CGAL.jl")

include("./sparse_pop/mix/pop_mix_CGAL.jl")
include("./sparse_pop/mix/basic_func_mix_CGAL.jl")
include("./sparse_pop/mix/model_cliq_mix_CGAL.jl")

end


