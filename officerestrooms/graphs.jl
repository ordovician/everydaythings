# Use this to plot the results from running the simulation
using Winston

# xs will contain the first line which is our header
(data, xs) = readcsv("simulation1.csv", has_header=true)

# even if header consists of numbers it will be read as an array of strings
# it seems so we need to convert it
xs = map(int64, xs)

# mean value for every column. Or rather the mean queue length for each
# population size
means = mean(data, 1)

no_cols = size(data,2)

# Median and max queue lengths for each population size
medians = map(col -> median(data[:,col]), 1:no_cols)
maxes = map(col -> maximum(data[:,col]), 1:no_cols)

# A plot where the axis are surrounding the plot instead of being in the centre
p = FramedPlot(
         title="Restroom queues",
         xlabel="Population",
         ylabel="Queue Length")

# add(p, Curve(xs, means, color="blue"))

# Each line adds a curve to the frameplot. Kind says what each point will
# look like.
add(p, Curve(xs, means, color="blue"))
add(p, Curve(xs, medians, color="green"))
add(p, Curve(xs, maxes, color="red"))
