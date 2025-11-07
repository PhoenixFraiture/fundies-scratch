use context starter2024

data TaxonomyTree:
    node(rank :: String, name :: String, children :: List<TaxonomyTree>)
end

# Example: Part of the cat family
lion = node("Species", "Panthera leo", [list: ])
tiger = node("Species", "Panthera tigris", [list: ])
leopard = node("Species", "Panthera pardus", [list: ])
panthera = node("Genus", "Panthera", [list: lion, tiger, leopard])

house-cat = node("Species", "Felis catus", [list: ])
wildcat = node("Species", "Felis silvestris", [list: ])
felis = node("Genus", "Felis", [list: house-cat, wildcat])

felidae = node("Family", "Felidae", [list: panthera, felis])

fun count-nodes(t):
  1 + c-n(t.children)
where:
  count-nodes(felidae) is 8
end

fun c-n(t):
  cases (List) t:
    | empty => 0
    | link(f, r) => count-nodes(f) + c-n(r)
  end
end

fun count-leaves(t):
  cases (List) t.children:
    | empty => 1
    | else => c-l(t.children)
  end
where:
  count-leaves(felidae) is 5
end
  
fun c-l(t):
  cases (List) t:
    | empty => 0
    | link(f, r) => count-leaves(f) + c-l(r)
  end
end


fun count-species(t):
 if t.rank == "Species":
    1 + c-s(t.children)
  else:
    c-s(t.children)
  end
where:
  count-species(felidae) is 5
  count-species(panthera) is 3
end

fun c-s(t):
  cases (List) t:
    | empty => 0
    | link(f, r) => count-species(f) + c-s(r)
  end
end

rank1 = "Genus"

fun count-rank(t):
  if t.rank == rank1:
    1 + c-r(t.children)
  else:
    c-r(t.children)
  end
where:
  count-species(felidae) is 2
  count-species(panthera) is 1
end

fun c-r(t):
  cases (List) t:
    | empty => 0
    | link(f, r) => count-rank(f) + c-r(r)
  end
end