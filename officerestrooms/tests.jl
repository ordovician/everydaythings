using Office

const duration = 10

restroom = Restroom(15)

println("population size: $(length(restroom.population))")
println("facilities sizee: $(length(restroom.facilities))")
println("-------------------------------------------------")

pop = restroom.population
# queue = restroom.queue


# for person in pop
#     indicies = find(facility -> Office.occupied(facility), restroom.facilities)
#     println("p: $(length(pop)) q: $(length(queue)) o: $(length(indicies))")
# 
#     enter!(restroom, person)
# 
# end
# 
# indicies = find(facility -> Office.occupied(facility), restroom.facilities)
# println("p: $(length(pop)) q: $(length(queue)) o: $(length(indicies))")

function no_occupied(room::Restroom)
    indicies = find(facility -> Office.occupied(facility), restroom.facilities)
    length(indicies)
 end

for t in 1:duration
    no_occupied_restrooms = no_occupied(restroom)
    println("$t p: $(length(pop)) q: $(length(restroom.queue)) o: $no_occupied_restrooms")
    
    queue = copy(restroom.queue)
    empty!(restroom.queue)
    
    if !isempty(queue)
        enter!(restroom, shift!(queue))
    end
    for person in restroom.population
        if need_to_go(person, duration)
            enter!(restroom, person)
        end
    end
    tick!(restroom)
    
end