use context starter2024
string-to-upper("hello cs2000!")

overlay(circle(20, "solid", "blue"),(rectangle(50, 40, "solid", "yellow")))

above(rectangle(30, 20, "solid", "green"),(rectangle(30, 20, "solid", "purple")))

rectangle(100, 20, "solid", "red")
rotate(45, rectangle(100, 20, "solid", "red"))

redhex = regular-polygon(40, 8, "solid", "red")
whitehex = regular-polygon(43, 8, "solid", "white")
stoptext = text-font("STOP", 36, "white", "Treasure Map Deadhand", "decorative", "normal", "normal", false)


overlay(overlay-align("center", "middle", stoptext, redhex)),(whitehex)

overlay-align("center", "middle", stoptext, redhex)