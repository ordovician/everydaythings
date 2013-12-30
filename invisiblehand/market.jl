function average_price(m::Market)
    round(mapreduce(p->p.price, +, m.producers) / length(m.producers), 2)
end

supply(m::Market) = mapreduce(p->p.supply, +, m.producers)
demand(m::Market) = mapreduce(c->c.demands, +, m.consumers)

function cheapest_producer(m::Market) 
    reduce(nothing, m.producers) do memo, supplier
        if memo == nothing || supplier.price < memo.price
            supplier
        else
            memo
        end
    end
end

