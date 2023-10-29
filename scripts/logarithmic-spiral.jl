using GLMakie

function plotgraph(; axis::Axis, figurecanvas::Figure, points::Bool, guides::Bool)

    spiralpoints = 1000    # Define the number of points.
    scalefactor = 0.2      # Size of the spiral.
    angularfrequency = 0.2 # Angular frequency (rotational)
    rotationalturns = 10    # Spiral turns.

    # Make sure invalid numbers wouldn't pass.
    if spiralpoints ≤ 1
        println("ERROR: Invalid spiral input points.")
        println("The minimum requirement is 2.")
        exit()
    end

    # Generate an array of thetas.
    theta = range(0, stop=rotationalturns * 2 * π, length=spiralpoints)

    # Calculate the radius (distance between the point and the center of the canvas (0,0)).
    radius = scalefactor * exp.(angularfrequency * theta)

    # Of course, the radius is useless if we don't know where the radius line POINTS to, 
    # so we will calculate it's target coordinates by using the classic vector component
    # technique.
    xcoordinate = radius .* cos.(theta) # The horizontal component.
    ycoordinate = radius .* sin.(theta) # The vertical component.

    # Plot the 'guide' lines, AKA the one that connects the points with the 0, 0.
    if guides == true
        for (x, y) in zip(xcoordinate, ycoordinate)
            lines!(axis, [scalefactor, x], [0, y], color = :green)
        end
    end

    # Plot the input points.
    if points == true
        scatter!(axis, xcoordinate, ycoordinate, color = :red)
    end

    # Plot the lines.
    lines!(axis, xcoordinate, ycoordinate)

end

function main(; resolutionsize::Tuple{Int64, Int64}, points::Bool, guides::Bool)

    # Initialize a canvas figure with the size of 800x600.
    figurecanvas = Figure(resolution=resolutionsize)

    # Add an axis.
    axis = Axis(
        figurecanvas[1, 1],
        title="Logarithmic Spiral",
        xlabel="X Label",
        ylabel="Y Label"
    )

    # Plot a graph.
    plotgraph(
        axis=axis,
        figurecanvas=figurecanvas,
        start=start,
        points=points,
        guides=guides
    )

    # Launch the canvas.
    figurecanvas

end

# Intialize the function.
main(resolutionsize=(800, 600), points=false, guides=false)