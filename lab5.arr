use context dcic2024
include csv
include data-source

flights_53 = load-table:
  rownames,
  dep_time,
  sched_dep_time,
  dep_delay,
  arr_time,
  sched_arr_time,
  arr_delay,
  carrier,
  flight,
  tailnum,
  origin,
  dest,
  air_time,
  distance,
  hour,
  minute,
  time_hour

  source: csv-table-file("flights_sample53.csv", default-options)
  sanitize rownames using num-sanitizer
  sanitize dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize flight using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end



unknown = transform-column(flights_53, "tailnum", lam(o): 
    if o == "":
      "UNKNOWN"
    else:
      o
    end
  end)
      
no-delay = transform-column(unknown, "dep_delay", lam(r): if r < 0:
      r - r
    else:
      r
    end
  end)

no-delay2 = transform-column(no-delay, "arr_delay", lam(r): if r < 0:
      r - r
    else:
      r
    end
  end)

flight-to-string = transform-column(no-delay2, "flight", lam(o): num-to-string(o) end)

fun trim(s :: String) -> String:
  doc: "Remove spaces from the given string."
  n = string-length(s)
  if n == 0:
    ""
  else:
    r = string-replace(s, " ", "")
    string-to-upper(r)
  end
end

trim-carrier = transform-column(flight-to-string, "carrier", trim)

make-time = transform-column(trim-carrier, "dep_time", lam(o): 
    a = o / 100
    b = num-to-string-digits(a, 2)
    c = string-replace(b, ".", ":")
    if string-length(c) < 5:
      string-append("0", c)
    else:
      c
    end
  end)

final-task2 = build-column(make-time, "dedup-key", lam(o):
    o["flight"] + "-" + o["carrier"] + "-" + o["dep_time"]
  end)

final-task2


freq-bar-chart(final-task2, "flight")

scatter-plot(final-task2, "air_time", "distance")

var distance1 = extract distance from final-task2 end

fun total-distance(fun-distance):
  block:
    var total = 0
    for each(n from fun-distance):
      total := total + n
  end
  total
end
end

fun avg-distance(fun-distance):
  block:
    var total = 0
    for each(n from fun-distance):
      total := (total + n)
  end
    total / length(fun-distance)
end
end

fun max-distance(fun-distance):
  block:
    var total = 0
    for each(n from fun-distance):
      if total > (total + n):
        total := (total)
        else:
        total
      end
    end
    total
  end
end
        

# I tried to write a sorting algorithm to find the max number but it didnt work. Pyret syntax is confusing :(