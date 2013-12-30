module Econ

export  Producer,
        Consumer,
        Market,
        produce!,
        buy!,
        supply,
        demand,
        average_price,
        SIMULATION_DURATION ,
        NUM_OF_PRODUCERS,
        NUM_OF_CONSUMERS,
        
        MAX_STARTING_SUPPLY,
        SUPPLY_INCREMENT,
        
        COST,
        MAX_ACCEPTABLE_PRICE,
        MAX_STARTING_PROFIT,
        PRICE_INCREMENT,
        PRICE_DECREMENT
        
type Producer
    price::Float64
    supply::Float64
end

type Consumer
   demands::Float64 
end

type Market
    producers::Vector{Producer}
    consumers::Vector{Consumer}
end

include("constants.jl")
include("producer.jl")
include("consumer.jl")
include("market.jl")

end