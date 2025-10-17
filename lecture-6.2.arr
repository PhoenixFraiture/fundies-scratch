use context starter2024

fun my-len(l):
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + my-len(r)
  end
where:
  my-len([list: 1, 2, 3]) is 1 + my-len([list:2, 3])
  my-len([list: 2, 3]) is 1 + my-len([list:3])
  my-len([list: 3]) is 1 + my-len([list: ])
  my-len([list: ]) is 0
end


fun string-concat(l):
  cases (List) l:
    | empty => ""
    | link(f, r) => f + string-concat(r)
  end
where:
  string-concat([list: "hello", "world"]) is "helloworld"
  string-concat([list: "phoenix", "fraiture"]) is "phoenixfraiture"
end

fun string-upper(l):
  cases (List) l:
    | empty => empty
    | link(f, r) => link(string-to-upper(f), string-upper(r))
  end
where:
  string-upper([list: "hello", "world"]) is [list: "HELLO", "WORLD"]
  string-upper([list: "phoenix", "fraiture"]) is [list: "PHOENIX", "FRAITURE"]
end
      

fun round-numbers(l):
  cases (List) l:
    | empty => empty
    | link(f, r) => link(num-round(f), round-numbers(r))
  end
where:
  round-numbers([list: 5.22, 6.5, 10.1, 20.9]) is [list: 5, 7, 10, 21]
  
end