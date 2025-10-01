use context dcic2024

include csv
include data-source

orders = table: time, amount
  row: "08:00", 10.50
  row: "09:30", 5.75
  row: "10:15", 8.00
  row: "11:00", 3.95
  row: "14:00", 4.95
  row: "16:45", 7.95
end

fun is-morning(t):
  t["time"] < "12:00"
end

filter-with(orders, lam(t): t["time"] < "12:00" end)

new-order = orders.order-by("time", false)
new-order
new-order.row-n(0)
  

forest = load-table:
  Location :: String,
  Subject :: String,
  Date :: Number
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/photos.csv", default-options)
end

forestfilter = filter-with(forest, lam(o): o["Subject"] == "Forest" end)

forest-order = forestfilter.order-by("Date", true)
forest-order.row-n(8)

forest-count = count(forest, "Location")
forest-count.order-by("count", false)

freq-bar-chart(forest, "Location")