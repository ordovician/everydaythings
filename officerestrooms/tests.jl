using Office

restroom = Restroom(4)

pop = restroom.population

println("Total population $(length(pop))")

for i in 1:20
    println("$(need_to_go(first(pop), 3))")
end


