using GLMakie

function plotgraph(; axis::Axis, figurecanvas::Figure, size::Float64, degree::Float64, angularfreq::Float64, turns::Int64, points::Int64)

    spiralpoints = points          # Define the number of points.
    scalefactor = size             # Size of the spiral.
    angularfrequency = angularfreq # Angular frequency (rotational)
    rotationalturns = turns        # Spiral turns.

    # Generate an array of thetas.
    theta = range(0, stop=rotationalturns * 2 * π, length=spiralpoints)

    # Calculate the radius (distance between the point and the center of the canvas (0,0)).
    radius = scalefactor * exp.(angularfrequency * theta)

    # Of course, the radius is useless if we don't know where the radius line POINTS to, 
    # so we will calculate it's target coordinates by using the classic vector component
    # technique.
    xcoordinate = radius .* cos.(theta) # The horizontal component.
    ycoordinate = radius .* sin.(theta) # The vertical component.

    rotationmatrix = [[cos(degree) - sin(degree)], [sin(degree) + cos(degree)]]

    xrotated::Vector{Float64} = []
    yrotated::Vector{Float64} = []

    for (x, y) in zip(xcoordinate, ycoordinate)
        push!(xrotated, x * rotationmatrix[1][1])   
        println("X: " * string(x * rotationmatrix[1][1]))
        push!(yrotated, y * rotationmatrix[2][1])
        println("Y: " * string(y * rotationmatrix[1][1]))
    end

    # Plot!
    lines!(axis, xrotated, yrotated)

end

function setup(; resolutionpixel::Tuple{Int64, Int64}, size::Float64, linesquantity::Int64, angularfreq::Float64, turns::Int64, points::Int64)

    # Initialize a canvas figure with the size of 800x600.
    figurecanvas = Figure(resolution=resolutionpixel)

    # Add an axis.
    axis = Axis(
        figurecanvas[1, 1],
        title="Logarithmic Spiral",
        xlabel="X Label",
        ylabel="Y Label"
    )

    degreelist = []

    # Generate the degree list.
    for i in 1:linesquantity
        push!(degreelist, 360 / linesquantity * i)
    end

    println("\nPlotting graphs:")

    # Plot the graph.
    for (index, value) in enumerate(degreelist)
        println("---------------- Curve " * string(index) * string(value) * " degrees:")
        plotgraph(
            axis=axis, 
            figurecanvas=figurecanvas, 
            size=size,
            degree=value,
            angularfreq=angularfreq,
            turns=turns,
            points=points
        )
    end
    
    # Launch the canvas.
    figurecanvas

end

function main(; width::Int64, height::Int64, size::Float64, line::Int64, points::Int64, turns::Int64, angularfreq::Float64) 
    setup(
        resolutionpixel=(width, height),
        size=size / 5,
        linesquantity=line,
        angularfreq=angularfreq,
        turns=turns,
        points=points
    )
end

# Intialize the function.
main(
    width=800,
    height=600,
    size=1.0,
    line=1000,
    points=1000,
    turns=2,
    angularfreq=0.9
)