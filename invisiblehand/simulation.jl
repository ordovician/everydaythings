
producers = map(1:NUM_OF_PRODUCERS) do
    Producer(COST + rand(0:MAX_STARTING_PROFIT), 
             rand(0:MAX_STARTING_SUPPLY))
end

consumers = map(1:NUM_OF_CONSUMERS) do
    Consumer(0)
end

generated_demand = map(1:SIMULATION_DURATION) do n
    round((sin(n) + 2) * 20)
end

demand_supply = Array(Float64, SIMULATION_DURATION, 3)
price_demand = Array(Float64, SIMULATION_DURATION, 3)

for t in 1:SIMULATION_DURATION
    fill!(consumers, generated_demand[t])
    demand_supply[t,:] = [t, market.demand, market.supply]
    
    for producer in producers
        produce!(producer, market)
    end
    
    price_demand[t,:] = [t, market.avergage_price, market.demand]
    
    while market.demand > 0 && market.supply > 0
        for consumer in consumers
            buy!(consumer, market)
        end
    end
end

