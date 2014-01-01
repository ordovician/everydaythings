function generate_goods!(p::Producer, market::Market) 
    if average_price(market) > COST
        p.supply += SUPPLY_INCREMENT 
    end
end

function produce!(p::Producer, market::Market)
    if p.supply > 0
        if p.price > COST
            p.price = max(p.price * PRICE_DECREMENT, COST)
        end
    else
        p.price *= PRICE_INCREMENT
        generate_goods!(p, market)
    end
end

