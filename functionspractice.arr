use context starter2024
#function practice

fun three-stripe-flag(top, middle, bot):
  frame(
    above(rectangle(120, 30, "solid", top),
      above(rectangle(120, 30, "solid", middle),
        rectangle(120, 30, "solid", bot))))
end

three-stripe-flag("red", "yellow", "green")

fun shoppinglist(first, second, third):
  doc:"bello"
  frame(
    above(text(first, 30, "white"),
      above(text(second, 30, "white"),
        text(third, 30,"white"))))
end

shoppinglist("tomatoes", "beans", "pears")
shoppinglist("sauce", "can", "pasta")


fun fahren-celci(fahren-heit):
  (fahren-heit * 1.8) + 32
end

fahren-celci(10)