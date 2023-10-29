using GLMakie

function logfunc(axis, figurecanvas)

    xcoordinate = range(0.01, stop=10, length=100)
    ycoordinate = log.(10, xcoordinate)

    return lines!(axis, xcoordinate, ycoordinate)

end

function expfunc(axis, figurecanvas)

    xcoordinate = range(-10, stop=3, length=100)
    ycoordinate = exp.(xcoordinate)

    return lines!(axis, xcoordinate, ycoordinate)

end

function main(resolutionsize)

    # Initialize a canvas figure with the size of 800x600.
    figurecanvas = Figure(resolution=resolutionsize)

    # Add an axis.
    axis = Axis(
        figurecanvas[1, 1],
        title="Logarithmic vs Exponential Function",
        xlabel="X Label",
        ylabel="Y Label"
    )

    # Plot a graph.
    logf = logfunc(axis, figurecanvas)
    expf =  expfunc(axis, figurecanvas)

    Legend(
        figurecanvas[1, 2],
        [expf, logf],
        ["Exponent", "Logarithm"]
    )

    # Launch the canvas.
    figurecanvas

end

# Intialize the function.
main((800, 600))