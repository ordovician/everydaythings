# Chapter 3. Offices and Restrooms

This is based on code from Chapter 3, in "Exploring Everyday Things with R and Ruby". What we are trying to find out is how many facilities do one need in a restroom for an office at a given size.

The simulation calculates the length of the queue to the office for office with 10 to 600 workers. The simulation records queue length every minute of the working day, which will typically amount to 540 minutes. The assumption is that the average worker needs to go on average 3 times to the restroom in the course of a day.

Compared to the original ruby code the code has been factored into a bit more functions for easy testing. The way arrays are handled is done in a way which feels more natural to Julia, which has good support for multidimensional arrays out of the box.

## How to run

Open a julia prompt with this directory set as working directory. Then write:

	 include("simulation.jl")
	 include("graphs.jl")
	 
For the graphics to work you need to install Winston. Typically this should work:

	Pkg.add("Winston")
	
But given that Julia is such a young language you might have all kinds of problems and should consider visualizing in *R* or using whatever graphing library you can get working on Julia. I instealled most prerequisite libraries for Winston using Homebrew.