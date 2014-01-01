# Use this to plot the results from running the simulation
using Winston

data = readcsv("demand_supply.csv", has_header=false)

xs = data[:,1]
demand = data[:,2]
supply = data[:,3]

# A plot where the axis are surrounding the plot instead of being in the centre
p = FramedPlot(
         title="Demand and supply",
         xlabel="time",
         ylabel="amount")
         
demand_curve = Curve(xs, demand, color="blue")
setattr(demand_curve, label="demand")

supply_curve = Curve(xs, supply, color="green")
setattr(supply_curve, label="supply")

# Each line adds a curve to the frameplot. Kind says what each point will
# look like.
add(p, demand_curve)
add(p, supply_curve)

l = Legend(0.75, 0.15, {demand_curve, supply_curve})
add(p, l)