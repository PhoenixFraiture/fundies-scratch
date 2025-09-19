use context starter2024

orange-triangle = triangle(35, "solid", "orange")

sidelength = 50
color = "blue"

square(sidelength, "solid", color)
square(50, "solid", "blue")

circleradius = 30
rectanglelength = 100
yellowcircle = circle(circleradius, "solid", "yellow")
blackrectangle = rectangle(50, rectanglelength, "solid", "black")

big-i = above(yellowcircle, blackrectangle)
big-i

yellowcircles = beside(yellowcircle, yellowcircle)
above(yellowcircles, blackrectangle)

luxembourg = above(
  above(
    rectangle(100, 25, "solid", "red"),
    rectangle(100, 25, "solid", "white")),(
    rectangle(100, 25, "solid", "cornflower-blue")))

luxembourg