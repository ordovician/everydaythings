const DURATION = 10

type Person
    use_duration::Int32
    frequency::Int32
end

Person(use_duration::Int64, frequency::Int64) = Person(int32(use_duration), int32(frequency))
Person() = Person(int32(4), int32(1))
    
population = Set{Person}()

need_to_go(p::Person) = rand() * DURATION + 1 <= p.frequency
