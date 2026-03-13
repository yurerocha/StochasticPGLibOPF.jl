# ------------------------------ Type declarations -----------------------------
const FloatVarRef = Union{Float64, JuMP.VariableRef}
# const VectorSet{T <: Number} = Union{Vector{T}, Set{T}}
const VectorSet = Union{Vector{Int64}, Set{Int64}}
const AffQuadExpr = Union{JuMP.AffExpr, JuMP.QuadExpr}
const Tuple3I = Tuple{Int64, Int64, Int64}
const CandType = Tuple{Tuple3I, Int64}

# -------------------------- Instance data structures --------------------------
struct CostData
    voltage_classes::Vector{String}
    reactances_km::Dict{String, Float64}
    costs_km::Dict{String, Float64} # Costs in $/km-hr
    transformers::Dict{Tuple{String, String}, Float64} # Costs in $/MVA-hr
    gen_costs_mult::Dict{String, Float64} # Inflation adjustments for gen costs
end

mutable struct GeneratorInfo
    bus::Int64
    lower_bound::Float64
    upper_bound::Float64
    costs::Vector{Float64}
end

mutable struct Scenario
    # id::Int64
    p::Float64 # Probability
    D::Dict{Int64, Float64} # Load
    G::Dict{Int64, GeneratorInfo}
end

mutable struct BranchInfo
    f_bar::Float64 # Capacity of circuits
    x::Float64 # Reactance of circuits
    gamma::Float64 # Susceptance of circuits
    cost::Float64 # Cost of candidate circuits
    Dtheta_bounds::Tuple{Float64, Float64}
end

mutable struct Instance
    name::String
    I::Set{Int64} # Buses
    J::Dict{Tuple3I, BranchInfo} # Existing lines
    K::Dict{CandType, BranchInfo} # Candidates
    key_to_index::Dict{CandType, Int64}
    costs::Vector{Float64}
    # f_bar::Vector{Float64} # Capacity of circuits
    # gamma::Vector{Float64} # Susceptance of circuits
    # Dtheta_limits::Vector{Tuple{Float64, Float64}} 
    # costs::Vector{Float64} # Cost of candidate circuits
    num_I::Int64 # Number of buses
    num_J::Int64 # Number of existing circuits
    num_K::Int64 # Number of candidate circuits
    ref_bus::Int64
    scenarios::Vector{Scenario}
    num_scenarios::Int64
end