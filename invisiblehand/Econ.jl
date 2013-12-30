module Econ

export  Producer,
        Consumer,
        Market,
        produce!,
        buy!
        
type Producer
    price::Float64
    supply::Float64
end

type Consumer
   demands::Float64 
end

type Market
    producers::Vector{Producer}
    average_price::Float64
    function Market(producers)
        average_price = 
            round(mapreduce(p->p.price, +, producers) / length(producers), 2)
    end
end

include("constants.jl")
include("producer.jl")
# include("consumer.jl")
include("market.jl")

end