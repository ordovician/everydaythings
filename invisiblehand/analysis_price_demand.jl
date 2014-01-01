# Use this to plot the results from running the simulation
using Winston

data = readcsv("price_demand.csv", has_header=false)

xs = data[:,1]
price = data[:,2]
demand = data[:,3]

# A plot where the axis are surrounding the plot instead of being in the centre
p = FramedPlot(
         title="Price and Demand",
         xlabel="time",
         ylabel="amount")
         
demand_curve = Curve(xs, log2(demand) - 3, color="blue")
setattr(demand_curve, label="demand")

price_curve = Curve(xs, price, color="green")
setattr(price_curve, label="price")

# Each line adds a curve to the frameplot. Kind says what each point will
# look like.
add(p, demand_curve)
add(p, price_curve)

l = Legend(0.75, 0.9, {demand_curve, price_curve})
add(p, l)