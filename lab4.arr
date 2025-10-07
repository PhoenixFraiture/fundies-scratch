use context dcic2024
include csv
include data-source

flights = load-table: 
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
  source: csv-table-file("flights.csv", default-options)
  sanitize dep_time using num-sanitizer
  sanitize dep_delay using num-sanitizer
  sanitize sched_dep_time using num-sanitizer
  sanitize arr_time using num-sanitizer
  sanitize sched_arr_time using num-sanitizer
  sanitize arr_delay using num-sanitizer
  sanitize air_time using num-sanitizer
  sanitize distance using num-sanitizer
  sanitize hour using num-sanitizer
  sanitize minute using num-sanitizer
end

flights

fun is-long-flight(r):
  r["distance"] >= 1500
end

filter-flights = filter-with(flights, is-long-flight)

ordered-flights = filter-flights.order-by("air_time", false)

flights-r1 = ordered-flights.row-n(0)


flights-r1["carrier"]
flights-r1["origin"]
flights-r1["dest"]




fun is_delayed_departure(r):
  r["dep_delay"] >= 30
end

fun is_morning_sched_dep(r):
  r["sched_dep_time"] < 1200
end
  
delay = filter-with(flights, lam(r): r["dep_delay"] >= 30 end)

morning = filter-with(delay, lam(r): r["sched_dep_time"] < 1200 end)

worst-flights = filter-with(morning, lam(r): r["distance"] > 500 end)

biggest-delay = worst-flights.order-by("dep_delay", false)

bdelay-r1 = biggest-delay.row-n(0)

bdelay-r1["flight"]
bdelay-r1["origin"]
bdelay-r1["dep_delay"]



no-delay = transform-column(flights, "dep_delay", lam(r): if r < 0:
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

effective-speed = build-column(no-delay2, "effective_speed", lam(r): if r["air_time"] > 0:
      r["distance"] / (r["air_time"] / 60)
    else:
      r - r
    end
  end)
      
fastest = effective-speed.order-by("effective_speed", false)

fastest-r1 = fastest.row-n(0)

fastest-r1["carrier"]
fastest-r1["origin"]
fastest-r1["dest"]

table-t = extract arr_delay from flights
end

fun apply-arrival-discount(t):
  if (t >= 0) and (t <= 45):
    t - (t * 0.2)
  else:
    t
  end
end
    
