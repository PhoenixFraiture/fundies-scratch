use context starter2024

fun choose-hat(temp-in-C :: Number) -> String:
  doc: "determines appropriate head gear, with above 27C a sun hat, below nothing"
  if temp-in-C > 27:
    "sun hat"
  else if temp-in-C < 10:
    "winter hat"
  else:
    "no hat"
  end
end

fun choose-hat1(temp-in-C1 :: Number) -> String:
  doc: "determines appropriate head gear, with above 27C a sun hat, below 10 a winter hat, in the middle, nothing"
  ask:
    |temp-in-C1 > 27 then: "sun hat"
    |temp-in-C1 < 10 then: "winter hat"
    |otherwise: "no hat"
  end
end


fun add-glasses(outfit :: String) -> String:
  doc: "adds glasses to any outfit"
  outfit + " and glasses"
end

fun choose-hat-or-visor(
    temp-in-C3 :: String,
    has-visor :: Boolean) -> String:
  if (temp-in-C3 > 27) and (temp-in-C3 < 31):
    "sun hat"
  else if temp-in-C3 < 10:
    "winter hat"
  else if has-visor:
    if temp-in-C3 > 30:
      "visor"
    else if (temp-in-C3 > 27) and (temp-in-C3 < 31):
    "sun hat"
    else if temp-in-C3 < 10:
    "winter hat"
    else:
      "no visor"
    end
    else:
      "no hat or visor"
    end
  end
    
fun choose-outfit(temp-in-C2, has-visor):
  doc: "chooses an outfit"
  hat = choose-hat-or-visor(temp-in-C2, has-visor)
  add-glasses(hat)
end