use context dcic2024
include csv
include data-source


items = table: item :: String, x-coordinate :: Number, y-coordinate :: Number
  row: "Sword of Dawn",           23,  -87
  row: "Healing Potion",         -45,   12
  row: "Dragon Shield",           78,  -56
  row: "Magic Staff",             -9,   64
  row: "Elixir of Strength",      51,  -33
  row: "Cloak of Invisibility",  -66,    5
  row: "Ring of Fire",            38,  -92
  row: "Boots of Swiftness",     -17,   49
  row: "Amulet of Protection",    82,  -74
  row: "Orb of Wisdom",          -29,  -21
end

x-column = transform-column(items, "x-coordinate", lam(x): x - (x * 0.1) end)

transform-column(items, "y-coordinate", lam(y): y - (y * 0.1) end)

fun calc-distance(r :: Row) -> Number:
  doc: "does distance to origin from fields 'x-coordinate' and 'y-coordinate'"
  num-exact(
    num-sqrt(
      num-sqr(r["x-coordinate"]) + num-sqr(r["y-coordinate"])))
end

items-with-dist = build-column(items, "distance", calc-distance)
items-with-dist

items-order = items-with-dist.order-by("distance", true)
items-order.row-n(0)

transform-column(items, "item", lam(item1): string-repeat("X", string-length(item1))end)


things = table: thing :: String, price :: Number
  row: "sandwich", 10
  row: "more sandwich", 20
  row: "beer", 5
  row: "apple", 1
end

fun add-vat(r):
  r["price"] + (r["price"] * 0.2)
end

build-column(things, "total", add-vat)
 

ons = load-table:
  Code,
  Indicies,
  Aug-24,
  Sep-24,
  Oct-24,
  Nov-24,
  Dec-24,
  Jan-25,
  Feb-25,
  Mar-25,
  Apr-25,
  May-25,
  Jun-25,
  Jul-25,
  Aug-25
  source: csv-table-file("ons-cpih-aug25.csv", default-options)
  sanitize Aug-24 using num-sanitizer
  sanitize Sep-24 using num-sanitizer
  sanitize Oct-24 using num-sanitizer
  sanitize Nov-24 using num-sanitizer
  sanitize Dec-24 using num-sanitizer
  sanitize Jan-25 using num-sanitizer
  sanitize Feb-25 using num-sanitizer
  sanitize Mar-25 using num-sanitizer
  sanitize Apr-25 using num-sanitizer
  sanitize May-25 using num-sanitizer
  sanitize Jun-25 using num-sanitizer
  sanitize Jul-25 using num-sanitizer
  sanitize Aug-25 using num-sanitizer
end
ons


ons-difference = build-column(ons, "difference", lam(r): num-abs(r["Aug-24"] - r["Aug-25"])end)

ons-pct = build-column(ons-difference, "pct-difference", lam(r): ((r["difference"]) / ((r["Aug-24"] + r["Aug-25"]) / 2)) * 100 end)

ons-pct.order-by("pct-difference", false)