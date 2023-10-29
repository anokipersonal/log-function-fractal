using GLMakie

function baseten(axis, figurecanvas)

    xcoordinate = range(0.01, stop=10, length=100)
    ycoordinate = log.(10, xcoordinate)

    return lines!(axis, xcoordinate, ycoordinate)

end

function basetwo(axis, figurecanvas)

    xcoordinate = range(0.01, stop=10, length=100)
    ycoordinate = log.(2, xcoordinate)

    return lines!(axis, xcoordinate, ycoordinate)

end

function main(resolutionsize)

    # Initialize a canvas figure with the size of 800x600.
    figurecanvas = Figure(resolution=resolutionsize)

    # Add an axis.
    axis = Axis(
        figurecanvas[1, 1],
        title="Logarithmic Function",
        xlabel="X Label",
        ylabel="Y Label"
    )

    # Plot a graph.
    base10 = baseten(axis, figurecanvas)
    base2  = basetwo(axis, figurecanvas)

    Legend(
        figurecanvas[1, 2],
        [base10, base2],
        ["Base 10", "Base 2"]
    )

    # Launch the canvas.
    figurecanvas

end

# Intialize the function.
main((800, 600))