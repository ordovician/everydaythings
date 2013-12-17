using Office

const population_range = 10:10:600
const DURATION = 10

# maps population size to a restroom queue sizes
data = Dict{Int64, Vector{Int64}}()

for population_size in population_range
    restroom = Restroom(population_size)
    data[population_size] = queue_sizes_after(restroom, DURATION)    
end

lbl = [population_range]

csv = Vector{Int32}[]
push!(csv, lbl)

append!(csv, map(1:DURATION) do t
    
    # Get a row with 60 columns
    map(10:10:600) do population_size
        data[population_size][t]
    end
end)


writecsv("simulation1.csv", csv)