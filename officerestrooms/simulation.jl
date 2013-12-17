include("person.jl")
include("facility.jl")
include("restroom.jl")

const DURATION = 10
const frequency = 3
const facilities_per_restroom = 3
const use_duration = 1
const population_range = 10:10:600

function Restroom(population_size::Number)
    population = Set{Person}() 
    union!(population, [Person(frequency, use_duration) for i in 1:population_size])
    Restroom(facilities_per_restroom, population) 
end

function queue_sizes_after(restroom::Restroom, duration::Number)
    map(1:duration) do t
        queue_size = length(restroom.queue)
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
        queue_size
    end
end

# maps population size to a restroom queue sizes
data = Dict{Int64, Vector{Int64}}()

for population_size in population_range
    restroom = Restroom(population_size)
    data[population_size] = queue_sizes_after(restroom, DURATION)    
end

lbl = [population_range]

csv = Vector{Int32}[]
push!(csv, lbl)

append!(csv, map(1:DURATION) do t
    
    # Get a row with 60 columns
    map(10:10:600) do population_size
        data[population_size][t]
    end
end)


writecsv("simulation1.csv", csv)