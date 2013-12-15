const DURATION = 10

population = Set{Person}()

type Person
    use_duration::Int32
    frequency::Int32
    
    function Person()
        new(4, 1)
    end
end

need_to_go(p::Person) = rand() * DURATION + 1 <= p.frequency
