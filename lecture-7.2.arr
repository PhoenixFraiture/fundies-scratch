use context starter2024

data River:
  | merge(width :: Number, left :: River, right :: River)
  | stream(flow-rate :: Number)
end

# Example: A small river network
stream-a = stream(5)
stream-b = stream(3)
stream-c = stream(8)

merge-1 = merge(12, stream-a, stream-b)
main-river = merge(15, merge-1, stream-c)

fun total-flow(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => total-flow(left) + total-flow(right)
    | stream(flow) => flow
  end
where:
  total-flow(stream-a) is 5
  total-flow(main-river) is 16
end


fun count-merges(r :: River) -> Number:
  cases (River) r:
    | merge(width, left, right) => 1 + count-merges(left) + count-merges(right)
    | stream(flow) => 0
  end
where:
  count-merges(stream-a) is 0
  count-merges(main-river) is 2
end


fun count-streams(r):
  cases (River) r:
    | merge(width, left, right) => count-streams(left) + count-streams(right)
    | stream(flow) => 1
  end
where:
  count-streams(stream-a) is 1
  count-streams(main-river) is 3
end

fun max-width(r):
  cases (River) r:
    | merge(width, left, right) => num-max(width, num-max(max-width(left), max-width(right)))
    | stream(flow) => 0
  end
where:
  max-width(main-river) is 15
  max-width(merge-1) is 12
end

fun widen-river(r, n):
  cases (River) r:
    | merge(width, left, right) =>
      merge(
        width + n,
        widen-river(left, n),
        widen-river(right, n))
    | stream(flow) => stream(flow)
  end
where:
  widen-river(main-river, 10).width is 25
  widen-river(main-river, 10).left.width is 22
end

fun cap-flow(r, n):
  cases (River) r:
    | merge(width, left, right) => 
      merge(width,
        cap-flow(left, n),
        cap-flow(right, n))
    | stream(flow) => 
      if flow < n:
        stream(flow)
      else:
        stream(n)
      end
  end
where:
  cap-flow(stream-a, 4).flow-rate is 4
  cap-flow(stream-c, 10).flow-rate is 8
end

fun has-large-stream(r):
  cases (River) r:
    | merge(width, left, right) => 
      has-large-stream(left) or has-large-stream(right)
    | stream(flow) => 
      if flow > 5:
        true
      else:
        false
      end
  end
where:
  has-large-stream(stream-c) is true
  has-large-stream(stream-a) is false
end