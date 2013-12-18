# A restroom has a number of facilities each containing a toilet or urinal.
# There is a queue forming in the restroom wairing for an available facility.
# population are all the people outside the restroom
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

# Person enters restroom and either finds an empty facility or gets in line
function enter!(room::Restroom, person::Person)
   indicies = find(facility -> !occupied(facility), room.facilities)
   if isempty(indicies)
       push!(room.queue, person)
   else
       unoccupied_facility = room.facilities[first(indicies)]
       occupy!(unoccupied_facility, person, room.population)
   end
end

# Advance the time with one logic unit (typically this means 1 minute)
function tick!(room::Restroom)
    for f in room.facilities
        tick!(f, room.population)
    end
end
