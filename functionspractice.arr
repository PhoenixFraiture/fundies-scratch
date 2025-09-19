use context starter2024

fun tshirt-cost(amount, name):
  doc: "this is a function to calculate tshirt cost"
  (amount * 5) + (string-length(name) * 0.1)
end
  
tshirt-cost(4, "Go Team!")
tshirt-cost(7, "Hello World")



fun celsius-to-fahrenheit(celsius):
  doc: "converting celsius to fahrenheit"
  (celsius * 1.8) + 32
end

fun fahrenheit-to-celsius(fahrenheit):
  doc: "converting fahrenheit to celsius"
  (fahrenheit - 32) * 5/9
end

check:
  celsius-to-fahrenheit(0) is 32
  fahrenheit-to-celsius(32) is 0
  celsius-to-fahrenheit(10) is 50
  fahrenheit-to-celsius(86) is 30
  fahrenheit-to-celsius(-15) is%(within(0.01)) -26.1
end

fun street-sign(polygon, size, rotation, color, signtext):
  doc: "function to make any street sign. Enter the amount of sides the sign should have, the size of it, the rotation and the color. then enter the text on the sign. use 60 rotation for upside down"
  frame(
    overlay(text(signtext, 36, "white"),
      rotate(rotation, regular-polygon(size, polygon, "solid", color))))
end

