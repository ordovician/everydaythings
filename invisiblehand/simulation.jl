using Econ

producers = map(1:NUM_OF_PRODUCERS) do _
    Producer(float64(COST + rand(0:MAX_STARTING_PROFIT)), 
             float64(rand(0:MAX_STARTING_SUPPLY)))
end

consumers = map(1:NUM_OF_CONSUMERS) do _
    Consumer(0.0)
end

market = Market(producers, consumers)

generated_demand = map(1:SIMULATION_DURATION) do n
    round((sin(n) + 2) * 20)
end

demand_supply = Array(Float64, SIMULATION_DURATION, 3)
price_demand = Array(Float64, SIMULATION_DURATION, 3)

for t in 1:SIMULATION_DURATION
    fill!(consumers, Consumer(generated_demand[t]))
    demand_supply[t,:] = [t, demand(market), supply(market)]
    
    for producer in producers
        produce!(producer, market)
    end
    
    price_demand[t,:] = [t, average_price(market), demand(market)]
    
    while demand(market) > 0 && supply(market) > 0
        for consumer in consumers
            buy!(consumer, market)
        end
    end
end

writecsv("demand_supply.csv", demand_supply)
writecsv("price_demand.csv", price_demand)

