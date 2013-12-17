module Office
    
export  Restroom,
        Facility,
        Person,
        enter!,
        tick!,
        occupy!,
        need_to_go,
        queue_sizes_after

include("person.jl")
include("facility.jl")
include("restroom.jl")

const frequency = 3
const facilities_per_restroom = 3
const use_duration = 1

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

end