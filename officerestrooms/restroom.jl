type Restroom
    queue::Vector{Person}
    facilities::Vector{Facility}
    population::Set{Person}
end

function Restroom(facilities_per_restroom::Int64, population::Set{Person})
    Restroom(Person[], 
            [Facility() for i in 1:facilities_per_restroom],
            population)
end

function enter!(room::Restroom, person::Person)
   unoccupied_facility = find(facility -> !occupied(facility), facilities)
   if isempty(unoccupied_facility)
       push!(room.queue, person)
   else
       occupy!(unoccupied_facility, person, room.population)
   end
end

function tick!(room::Restroom)
    for f in room.facilities
        tick!(f, room.population)
    end
end
