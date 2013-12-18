# A person who needs to go to the restroom. 
type Person
    frequency::Int64
    use_duration::Int64
end

Person() = Person(4, 1)
    
# Each tick (minute) we roll a dice to figure out of person should go to restroom
need_to_go(p::Person, duration::Number) = rand(1:duration) <= p.frequency
