type Producer
    price::Floa64
    supply::Float64
end

generate_goods!(p::Producer, market::Market) = if market.price > COST; p.supply += SUPPLY_INCREMENT

function produce!(p::Producer, market::Market)
    if p.supply > 0
        if p.price > COST
            p.price *= PRICE_DECREMENT
        end
    else
        p.price *= PRICE_INCREMENT
        generate_goods!(p, market)
    end
end

