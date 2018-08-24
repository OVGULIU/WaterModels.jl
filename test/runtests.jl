using WaterModels
using AmplNLWriter
using Base.Test
using Cbc
using JuMP
#using KNITRO
using InfrastructureModels
using Memento
using Ipopt

# Suppress warnings during testing.
setlevel!(getlogger(InfrastructureModels), "error")
setlevel!(getlogger(WaterModels), "error")

# Solver setup.
cbc = CbcSolver(logLevel = 0)
bonmin = AmplNLSolver("couenne")
ipopt = IpoptSolver(print_level = 0)
#knitro = KnitroSolver(algorithm = KTR_ALG_AUTOMATIC, ms_enable = 1)

# Perform the tests.
@testset "WaterModels" begin
    #include("data.jl")
    #include("wf_hw.jl")
    #include("ne_hw.jl")
    #include("wf_dw.jl")
end
