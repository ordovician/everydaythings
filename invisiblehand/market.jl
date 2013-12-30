type Market
    producers::Vector{Producer}
    average_price::Float64
    function Market(producers)
        average_price = 
            round(mapreduce(p->p.price, +, producers) / length(producers), 2)
    end
end

supply(m::Market) = mapreduce(p->p.supply, +, m.producers)
demand(m::Market) = mapreduce(p->demands, +, m.producers)

function cheapest_producer(m::Market) 
    reduce(nothing, m.producers) do memo, supplier
        if memo == nothing || supplier.price < memo.price
            supplier
        else
            memo
        end
    end
end

