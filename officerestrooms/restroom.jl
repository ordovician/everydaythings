type Restroom
    queue::Vector{Person}
    facilities::Vector{Facility}
end

function Restroom(facilities_per_restroom)
    Restroom(Person[], [Facility() for i in 1:facilities_per_restroom])
end

Restroom() = Restroom(3) 

function enter!(room::Restroom, person::Person)
   unoccupied_facility = find(facility -> !occupied(facility), facilities)
   if isempty(unoccupied_facility)
       push!(room.queue, person)
   else
       occupy!(unoccupied_facility, person)
   end
end

function tick!(room::Restroom)
    for f in room.facilities
        tick!(f)
    end
end
