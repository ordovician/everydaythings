# A person who needs to go to the restroom. 
type Person
    use_duration::Int32
    frequency::Int32
end

Person(use_duration::Int64, frequency::Int64) = Person(int32(use_duration), int32(frequency))
Person() = Person(int32(4), int32(1))
    
need_to_go(p::Person, duration::Number) = rand() * duration + 1 <= p.frequency
