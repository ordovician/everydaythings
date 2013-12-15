# A facility at a restoom. Basically a toilet, which may be occupied by a person
type Facility
   occupier::Union(Person, Nothing)
   duration::Int32
   
   Facility() = new(nothing, 0)
end

# Let a person occupy toilet in restroom
function occupy!(f::Facility, person::Person)
   if occupied(f)
       return false
   end
   
   f.occupier = person
   f.duration = 1
   delete!(population, person)
   true
end

# Check if facility is occupied by a person
occupied(f::Facility) = !is(f.occupier, nothing)

# Make occupant leave facility
function vacate!(f::Facility)
    push!(population, f.occupier)
    f.occupier = nothing
end

# Advance the time in simulation. If occupant is finnished he/she will leave
function tick!(f::Facility)
   if occupied(f) && f.duration > f.occupier.use_duration
       vacate!(f)
       f.duration = 0
   elseif occupied(f)
       f.duration += 1
   end
end