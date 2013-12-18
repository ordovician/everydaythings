using Office

const population_range = 10:10:600
const DURATION = 540

# maps population size to a restroom queue sizes
data = Dict{Int64, Vector{Int64}}()

for population_size in population_range
    restroom = Restroom(population_size)
    data[population_size] = queue_sizes_after(restroom, DURATION)    
end


csv = Array(Int32, (DURATION + 1, length(population_range)))
csv[1,:] = population_range

for t in 1:DURATION
    column = 1
    for population_size in population_range
      csv[t+1, column] = data[population_size][t]
      column += 1
    end 
end

writecsv("simulation1.csv", csv)