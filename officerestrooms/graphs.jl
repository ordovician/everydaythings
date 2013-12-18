using Winston

# xs will contain the first line which is our header
(data, xs) = readcsv("simulation1.csv", has_header=true)

# even if header consists of numbers it will be read as an array of strings
# it seems so we need to convert it
xs = map(int32, xs)

# mean value for every column. Or rather the mean queue length for each
# population size
means = mean(data, 1)

no_cols = size(data,2)

# Median and max queue lengths for each population size
medians = map(col -> median(data[:,col]), 1:no_cols)
maxes = map(col -> max(data[:,col]), 1:no_cols)

# A plot where the axis are surrounding the plot instead of being in the centre
p = FramedPlot(
         title="Restroom queues",
         xlabel="Population",
         ylabel="Queue Length")
         
# add(p, Curve(xs, means, color="blue"))

# Each line adds a curve to the frameplot. Kind says what each point will
# look like.
add(p, Points(xs, means, kind="circle", color="blue"))
add(p, Points(xs, medians, kind="circle", color="green"))
add(p, Points(xs, maxes, kind="circle", color="red"))