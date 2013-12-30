module Econ

export  Producer,
        Consumer,
        Market,
        produce!,
        buy!,
        
    
include("constants.jl")
include("producer.jl")
include("consumer.jl")
include("market.jl")

end