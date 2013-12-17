# A person who needs to go to the restroom. 
type Person
    frequency::Int32
    use_duration::Int32
end

Person(frequency::Int64, use_duration::Int64) = Person(int32(frequency), int32(use_duration))
Person() = Person(int32(4), int32(1))
    
need_to_go(p::Person, duration::Number) = rand() * duration + 1 <= p.frequency
