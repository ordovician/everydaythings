using Office

const population_range = 10:10:600
const DURATION = 540

# maps population size to a restroom queue sizes
data = Array(Int64, (DURATION, length(population_range)))

# For each population size we find how many people stand in line throughout the day
for population_size in population_range
    restroom = Restroom(population_size)
    data[:,population_size/step(population_range)] = queue_sizes_after(restroom, DURATION)    
end

csv = Array(Int64, (DURATION + 1, length(population_range)))
csv[1,:] = population_range
csv[2:end,:] = data

writecsv("simulation1.csv", csv)