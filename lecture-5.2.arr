use context starter2024


discount-codes = [list: "NEWYEAR", "student", "NONE", "student", "VIP", "none"]

unique-codes = distinct(discount-codes)

fun is-real-code(code :: String) -> Boolean:
  not(string-to-lower(code) == "none")
end

real-codes = filter(is-real-code, unique-codes)
map(string-to-upper, real-codes)



yes-no = [list: "yes", "NO", "maybe", "Yes", "no", "Maybe"]

lower-yesno = map(string-to-lower, yes-no)

unique-yes-no = distinct(lower-yesno)

filter(lam(o): not(o == "maybe") end, unique-yes-no)


numbers = [list: 1, 2, 3, 4, 5, 6]
strings = [list: "hello", "world", "coding", "bingus"]

fun product(num-list)
  block:
  var total = 1
  for each(n from num-list):
    total := total * n
  end
  total
end

fun sum-even-numbers(num-list):
  block:
    var total = 0
    for each(n from num-list):
      if num-modulo(n, 2) == 0:
        total := total + n
      else:
        nothing
      end
    end
    total
  end
end

fun my-length(l):
  length(l)
end
      
fun my-doubles(l):
  map((lam(o): o * 2 end), l)
end

fun my-string-lens(l):
  map((lam(o): string-length(o) end), l)
end

fun my-alternating(l):
  var total = 0
  for each(n from l):
    for each(k from n):
      if num-modulo(k, 2) == 0:
        n
      else:
        nothing
      end
    end
  end
end

numbers1 = [list: 1, 2, 3]

fun my-sum(num-list :: List) -> Number block:
  var total = 0
  for each(n from num-list):
    total := total + n
  end
  total
end
