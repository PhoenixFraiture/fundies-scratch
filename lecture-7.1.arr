use context starter2024
l1 = [list: 1, -2, 3, -4]

fun my-pos-nums(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if f > 0:
        link(f, my-pos-nums(r))
      else: my-pos-nums(r)
      end
  end
where:
  my-pos-nums([list: 1, -2, 3, -4]) is link(1, my-pos-nums([list: -2, 3, -4]))
  my-pos-nums([list:    -2, 3, -4]) is         my-pos-nums([list:     3, -4])
  my-pos-nums([list:        3, -4]) is link(3, my-pos-nums([list:        -4]))
  my-pos-nums([list:           -4]) is         my-pos-nums([list:          ])
  my-pos-nums([list:             ]) is         [list: ]
end


fun my-alternating(l):
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      cases (List) r:
        | empty => [list: f]
        | link(fr, rr) => link(f, my-alternating(rr))
      end
  end
where:
  my-alternating([list: 1, 2, 3, 4, 5]) is [list: 1, 3, 5]
end

fun my-max(l):
  cases (List) l:
    | empty => raise("cannot max an empty list")
    | link(f, r) => 
      cases (List) r:
        | empty => f
        | link(fr, rr) => num-max(f, my-max(r))
      end
  end
where:
  my-max([list: 2, 1, 4, 3, 2]) is 4
end


fun my-running-sum(l):
  m-rs(0, l)
where: 
  my-running-sum([list: 1, 2, 3, 4, 5]) is [list: 1, 3, 6, 10, 15]
end

fun m-rs(memory, l):
  cases (List) l:
    | empty => empty
    | link(f, r) => link(f + memory, m-rs(f + memory, r))
  end
end

fun more-than-five(l):
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      if string-length(f) > 5:
        link(f, more-than-five(r))
        else:
        more-than-five(r)
      end
  end
where:
  more-than-five([list: "hello", "world", "bingus", "scringus"]) is [list: "bingus", "scringus"]
end

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
end

fun my-sum(l):
  cases (List) l:
    | empty      => 0
    | link(f, r) => f + my-sum(r)
  end
end


fun my-average(l):
  cases (List) l:
    | empty => raise("is empty")
    | else => my-sum(l) / my-len(l)
  end
where:
  my-average([list: 2, 1, 4, 3, 2, 0]) is 2
end

fun my-max-accum(l):
  m-ma(0, l)
where:
  my-max-accum([list: 4, 5, 3, 9, 4, 2]) is 9
end

fun m-ma(big-num, l):
  cases (List) l:
    | empty => big-num
    | link(f, r) => 
      if f > big-num:
        m-ma(f, r)
      else:
        m-ma(big-num, r)
      end
  end
end

fun my-alter-accum(l):
  m-aa(true, l)
where:
  my-alter-accum([list: 4, 6, 8, 9, 3]) is ([list: 4, 8, 3])
end

fun m-aa(alternater, l):
  cases (List) l:
    | empty => empty
    | link(f, r) => 
      if alternater == true:
        link(f, m-aa(false, r))
      else:
        m-aa(true, r)
      end
  end
end

