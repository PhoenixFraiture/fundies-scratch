use context starter2024

data Priority:
  | low
  | medium
  | high
end

data WeatherReport:
  | sunny(temperature)
  | rainy(temperature, precipitation)
  | snowy(temperature, precipitation, wind-speed)
end

fun is-severe(temp):
  cases (WeatherReport) temp:
    | sunny(a) => if a > 35: true else: false end
    | rainy(a, b) => if b > 20: true else: false end
    | snowy(a, b, c) => if c > 30: true else: false end
  end
end

data Status:
  | todo
  | in-progress
  | done
end

data Task:
  | task(description :: String, priority :: Priority, status :: Status)
  | note(description :: String)
end

fun status-to-string(s):
  cases (Status) s:
    | todo => "todo"
    | in-progress => "in progress"
    | done => "done"
  end
end


task-1 = task("Buy groceries", low, todo)
task-2 = task("Pay council tax", high, in-progress)
note-1 = note("Post Office closes at 4:30")

fun describe(t :: Task) -> String:
  cases (Task) t:
    | task(d, p, c) => "TASK: " + d + " " + status-to-string(c)
    | note(d) => "NOTE: " + d
  end
end

describe(task-1)
# "TASK: Buy groceries"

describe(note-1)
# "NOTE: Post Office closes at 4:30"


data Temperature:
  | Celcius(degrees)
  | Fahrenheit(degrees)
  | Kelvin(degrees)
end

fun to-celcius(deg):
  cases (Temperature) deg:
    | Fahrenheit(p) => (p - 32) * 5/9
    | Kelvin(p) => p - 273.15
    | Celcius(p) => p
  end
end

to-celcius(Kelvin(10))
to-celcius(Fahrenheit(50))
