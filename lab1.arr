use context starter2024

shirtnum1 = 5
shirtnum2 = 7

3 + (shirtnum1 * 12)
3 + (shirtnum2 * 12)
#the second result is larger because there are more shirts

width = 420
height = 594

perimeter = 2 * (width + height)
perimeter * 0.1
#if you forget the parenthesis you get an error message because Pyret doesn't know the order of operations you want to use

"Designs for everyone!"
"red" + "blue"
#you cannot add a string to a number. This is because they are different data types and strings don't have a number value that can be added to any number.
#you can however, concatenate 2 strings to eachother using the + operator.

base = rectangle(40, 100, "solid", "black")
red = circle(15, "solid", "red")
yellow = circle(15, "solid", "yellow")
green = circle(15, "solid", "green")
pole = rectangle(10, 75, "solid", "black")

first = overlay-align("center", "top", red, base)

second = overlay-align("center", "middle", yellow, first)

third = overlay-align("center", "bottom", green, second)

above(third, pole)

rectangle(20, 50, "solid", "black")
#the parameter for width was in the parameter for outlining the state of the image being solid. Also, the width and height parameters were switched.
circle(30, "solid", "red")
#I put quotes around the solid because without them the function doesn't know what it is. It thinks its an empty variable named solid. One could make solid = "solid" and then it would work.

luxembourg = above(above(rectangle(100, 25, "solid", "red"),rectangle(100, 25, "solid", "white")),(rectangle(100, 25, "solid", "cornflower-blue")))
luxembourg


shieldbase = rhombus(100, 70, "solid", "gray")
shieldstar = star-polygon(20, 10, 3, "solid", "yellow")

overlay-align("center", "middle", shieldstar, shieldbase)

#I'm told I need to label "complex" code. So here I took some shapes already in the Pyret library and overlayed them. I then changed the color of the shapes