using Office

const duration = 10

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


# Explanation of algorithm at inner loop. For each tick we record
# the following information: 
#   - how many are standing in line to go to the restroom
#   - 0 to 3 pieces of paper. One for each person present in a facility. When a person enters we write 2.
#   - how many are left in the rest of the office
# Each tick we deduct 1 from the facility cards. If there are less than 3 cards we
# keep reducing number of people in queue and add cards at the top of cardstack.
# As long as there are cards we start looking at the bottom of the stack and remove
# every card marked with 0. Each time we remove a card we increase population size with 1.
# Each tick we roll a dice for every office worker not in a facility or standing in line. The dice has duration number of sides. If we get less than frequence, we place
# person in line.
function test_alt()
    const freq = 3
    const no_facilities = 3
    const use_duration = 2
    
    const population_range = 10:10:600
    
    # println("population size: $population")
    # println("facilities sizee: $no_facilities")
    # println("-------------------------------------------------")
    
    data = Array(Int32, (duration, length(population_range)))
    for population_size in population_range
        population = population_size
        queue_length = 0
        # population  = 80
        facilities = Array(Int64, 0)
        for t in 1:duration
            popcount = population
            for i in 1:popcount
                if rand(1:duration) <= freq
                    queue_length += 1
                    population -= 1
                    
                    combined_pop = queue_length + population + length(facilities)
                    if combined_pop != population_size
                        error("t: $t i: $i | $queue_length + $population + $(length(facilities)) != $population_size")
                    end
                end           
            end 
        
            for i in 1:length(facilities)
               facilities[i] -= 1
               @assert facilities[i] >= 0
            end
        
            while !isempty(facilities) && first(facilities) == 0
                @assert length(facilities) > 0
                shift!(facilities)
                population += 1
                
                combined_pop = queue_length + population + length(facilities)
                if combined_pop != population_size
                    error("t: $t | $queue_length + $population + $(length(facilities)) != $population_size")
                end
            end
        
            while queue_length > 0 && length(facilities) < no_facilities
                push!(facilities, use_duration)
                queue_length -= 1
            end
            data[t,population_size/step(population_range)] = queue_length
            # println("p: $population q: $queue_length o: $(length(facilities))")
        end
    end
    
    csv = Array(Int32, (duration + 1, length(population_range)))
    csv[1,:] = population_range
    csv[2:end,:] = data

    writecsv("simulation1.csv", csv)
end


function test_occupation()
    restroom = Restroom(20)
    function no_occupied(room::Restroom)
        indicies = find(facility -> Office.occupied(facility), restroom.facilities)
        length(indicies)
    end
    println("population size: $(length(restroom.population))")
    println("facilities sizee: $(length(restroom.facilities))")
    println("-------------------------------------------------")
    
    for t in 1:duration
        
    
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
        
        no_occupied_restrooms = no_occupied(restroom)
        println("$t p: $(length(restroom.population)) q: $(length(restroom.queue)) o: $no_occupied_restrooms")        
        tick!(restroom)
    
    end
end


function test_need_to_go()
    const freq = 4
    const use_duration = 1   
   
    p = Person(freq, use_duration)

    visits = [need_to_go(p, 10) ? 1 : 0 for i in 1:1000]
    print("visits after 100 ticks:")
    println(sum(visits))    
end


function test_tick()
    const freq = 4
    const use_duration = 1
    const population_size = 2
    
    population = Set{Person}() 
    union!(population, [Person(freq, use_duration) for i in 1:population_size])
    
    f = Facility()
    occupy!(f, first(population), population)
    for i in 1:10
        println("$(Office.occupied(f))")
        tick!(f, population)
    end

end

test_alt()
# test_occupation()
# test_tick()

