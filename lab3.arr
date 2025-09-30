use context dcic2024
include csv
include data-source

fun leap-year-finder(year :: Number):
  doc: "leap years are found by checking if the year is divisible by 4 and not divisible by 100. This is because a leap year occurs every 4 years but skips 1 every 100"
  if (num-modulo(year, 4) == 0)and (num-modulo(year, 100) > 0):
    "this is a leap year"
  else:
    "not a leap year"
  end
where:
  leap-year-finder(2000) is "not a leap year"
  leap-year-finder(2012) is "this is a leap year"
end
    
fun tick(time :: Number):
  doc: "this function simply makes the time+1 and if it goes over 59 it resets it to 0."
  if time == 59:
    0
  else if time > 59:
    "time not available"
  else:
    time + 1
end
where: 
  tick(59) is 0
  tick(41) is 42
  tick(100) is "time not available"
end

fun rock-paper-scissors(player1 :: String, player2 :: String):
  doc: "player 1 and 2 input 2 answers and the function checks which one wins. Values must be in lowercase and be either rock, paper or scissors."
  if (player1 == "rock") and (player2 == "scissors"):
    "player 1 wins"
  else if (player1 == "scissors") and (player2 == "paper"):
    "player 1 wins"
  else if (player1 == "paper") and (player2 == "rock"):
    "player 1 wins"
  else if (player1 == "scissors") and (player2 == "rock"):
    "player 2 wins"
  else if (player1 == "paper") and (player2 == "scissors"):
    "player 2 wins"
  else if (player1 == "rock") and (player2 == "paper"):
    "player 2 wins"
  else if player1 == player2:
    "its a tie"
  else:
    "not a valid answer"
  end
where:
  rock-paper-scissors("rock", "paper") is "player 2 wins"
  rock-paper-scissors("rock", "rock") is "its a tie"
end

planets = table: Planet :: String, Distance :: Number
  row: "Mercury", 0.39
  row: "Venus", 0.72
  row: "Earth", 1
  row: "Mars", 1.52
  row: "Jupiter", 5.2
  row: "Saturn", 9.54
  row: "Uranus", 19.2
  row: "Neptune", 30.06
end
#this table has a list of all the planets in our solar system and the distance they are from the sun. This is done at a scale with our Earth as a constant "1".
mars = planets.row-n(3)
mars.get-value("Distance")

something = load-table:
  year :: Number,
  day :: Number,
  month :: String,
  rate :: Number
  source: csv-table-file("boe_rates.csv", default-options)
  sanitize year using num-sanitizer
  sanitize day using num-sanitizer
  sanitize rate using num-sanitizer
end
#this table shows the Official Bank Rate history data from the Bank of EnglandLinks to an external site. with rates from 1844 onwards.
something.all-rows
median(something, "rate")
modes(something, "rate")

something.order-by("rate", true)
something.order-by("rate", false)