type Restroom
    queue::Vector{Person}
    facilities::Vector{Facility}
    
    function Restroom()
        new(Person[],3)
    end
end

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
