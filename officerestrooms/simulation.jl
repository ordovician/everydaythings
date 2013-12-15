

const frequency = 3
const facilities_per_restroom = 3
const use_duration = 1
const population_range = 10:600

# maps population size to a restroom queue sizes
data = Dict{Int32, Vector{Int32}}

for population_size in population_range
    empty!(population)
    for i in population_size
        push!(population, Person(frequency, use_duration))
        restroom = Restroom(facilities_per_restroom)
        
        data[population_size] = map(1:DURATION) do t
            queue_size = length(restroom.queue)
            queue = copy(restroom.queue)
            empty!(restroom.queue)
        
            if !isempty(queue)
                enter!(restroom, shift!(queue))
            end
            for person in population
                if need_to_go(person)
                    enter!(restroom, person)
                end
            end
            tick!(restroom)
            queue_size
        end     
    end
end

lbl = [10:10:600]

csv = Vector{Int32}[]
push!(csv, lbl)

append!(csv, map(1:DURATION) do t
    
    # Get a row with 60 columns
    map(10:10:600) do population_size
        data[population_size][t]
    end
end)


writecsv("simulation1.csv", csv)