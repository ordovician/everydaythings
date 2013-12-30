const MAX_ACCEPTABLE_PRICE = 

type Consumer
   demands::Float64 
end

# keep buying from cheapest producer with goods left until demand satisfied
function buy!(c::Consumer, market::Market)
    while c.demands > 0 && market.supply > 0
        cheapest = cheapest_producer(market)
        if cheapest != nothing
            if cheapest.price > MAX_ACCEPTABLE_PRICE
                c.demands *= 0.5
            end
            if c.demands > cheapest.supply
                c.demands - cheapest.supply
                cheapest.supply = 0
            else
                cheapest.supply -= c.demands
                c.demands = 0
            end
        end
    end
end
    