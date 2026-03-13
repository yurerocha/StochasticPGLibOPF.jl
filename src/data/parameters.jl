const const_eps = 1e-5
const MAXINT = 2e9 # Gurobi MAXINT value
const const_infinite = 2.0e9
const mp_type_ref_bus = 3

Base.@kwdef mutable struct InstanceParameters
    seed::Int64 = 123 # Used for generating random number for the instance
    load_gen_mult::Float64 = 2.0 # Multiplier for the load and generation
    g_slack::Float64 = 0.15 # Generation slack with respect to the load
    cost_delta_mult::Float64 = 1e-2 # Value multiplied by the delta in cost
    num_candidates::Int64 = 2 # Number of candidates available per existing line
    # cost_mult::Float64 = 1e2 # Value multiplied by x to build the costs
    ref_bus::Int64 = 1 # Default reference bus used when none is found
    expected_lifetime::Int64 = 50 # Expected lifetime of the new lines in years
end

Base.@kwdef mutable struct StochasticInstanceParameters
    selection_percentile::Float64 = 0.8
    rounding_digits::Int64 = 2
end

Base.@kwdef mutable struct Parameters
    log_level::Int64 = 2
    log_dir::String = "logs"
    log_file::String = "log.txt"
    debugging_level::Int64 = 0
    instance::InstanceParameters = InstanceParameters()
    stochastic_instance::StochasticInstanceParameters = 
                                                  StochasticInstanceParameters()
end