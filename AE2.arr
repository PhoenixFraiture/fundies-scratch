use context dcic2024
include csv
include data-source


penguins =
  load-table:
    number, species, island, bill_length_mm, bill_depth_mm,
    flipper_length_mm, body_mass_g, sex, year
    source: csv-table-file("penguins.csv", default-options)
    sanitize number using num-sanitizer
    sanitize bill_length_mm using num-sanitizer
    sanitize bill_depth_mm using num-sanitizer
    sanitize flipper_length_mm using num-sanitizer
    sanitize body_mass_g using num-sanitizer
  end

species-list = extract species from penguins end
bill-depth-list = extract bill_depth_mm from penguins end
bill-length-list = extract bill_length_mm from penguins end
flipper-list = extract flipper_length_mm from penguins end
bodymass-list = extract body_mass_g from penguins end
sex-list = extract sex from penguins end


#helper functions
fun len-list(l :: List) -> Number:
  doc: "finds length of given list"
  cases (List) l:
    | empty => 0
    | link(f, r) => 1 + len-list(r)
  end
end
check:
    len-list([list: 1, 2, 3]) is 3
    len-list(empty) is 0
end

fun sum-list(l :: List) -> Number:
  doc: "finds sum of given list"
  cases (List) l:
    | empty => 0
    | link(f, r) => f + sum-list(r)
  end
end
check:
  sum-list([list: 1, 2, 3]) is 6
  sum-list(empty) is 0
end

fun string-is-equal(a :: String, b :: String) -> Boolean:
  doc: "checks if two lists are equal"
  string-to-lower(a) == string-to-lower(b)
end
check:
  string-is-equal("Adelie", "adelie") is true
  string-is-equal("GENTOO", "gentoo") is true
  string-is-equal("Adelie", "Chinstrap") is false
end

#scalar
fun collect-depths(sp-list :: List, depth-list :: List, target :: String) -> List:
  doc: "collects bill depths from dataset"
  cases (List) sp-list:
    | empty => empty
    | link(f, r) =>
      cases (List) depth-list:
        | empty => raise("cannot process empty list")
        | link(fd, rd) =>
          if string-is-equal(f, target):
            link(fd, collect-depths(r, rd, target))
          else:
            collect-depths(r, rd, target)
          end
      end
  end
end
check:
  collect-depths(
    [list: "Adelie", "Adelie", "Gentoo"],
    [list: 18.4, 17.8, 14.2],
    "Adelie"
  ) is [list: 18.4, 17.8]
end


fun average-depth-for-species(sp-list :: List, depth-list :: List, target :: String) -> Number:
  doc: "calculates average bill depth"
  ds = collect-depths(sp-list, depth-list, target)
  if ds == empty:
    nothing
  else:
    sum-list(ds) / len-list(ds)
  end
end
check:
  average-depth-for-species(
    [list: "Adelie", "Adelie", "Gentoo"],
    [list: 18.4, 17.8, 14.2],
    "Adelie"
  ) is 18.1
end

#transformation
fun ratio-list(bill-list :: List, mass-list :: List) -> List:
  doc: "This function traverses two lists in parallel and finds the ratio of the two numbers for each element. This function is designed for bill length and mass but any two lists that contain numbers can have their ratio found"
  cases (List) bill-list:
    | empty => empty
    | link(f, r) =>
      cases (List) mass-list:
        | empty => raise("cannot process empty list")
        | link(fr, rr) =>
          if (fr == nothing) or (f == nothing):
            ratio-list(r, rr)
          else:
            link(f / fr, ratio-list(r, rr))
          end
      end
  end
end
check:
  ratio-list(
    [list: 39, 41, 50],
    [list: 3900, 4100, 5000]
  ) is [list: 0.01, 0.01, 0.01]
  ratio-list(
    [list: 40, nothing, 50],
    [list: 4000, 3000, nothing]
  ) is [list: 0.01]
end

#selection

fun collect-flippers(l :: List) -> List:
  doc: "function to collect flipper lengths"
  cases (List) l:
    | empty => empty
    | link(f, r) =>
      if f == nothing:
        collect-flippers(r)
      else:
        link(f, collect-flippers(r))
      end
  end
end



fun average-flipper(l :: List):
  doc: "function to find average flipper length based on collect-flippers"
  fls = collect-flippers(l)
  if fls == empty:
    nothing
  else:
    sum-list(fls) / len-list(fls)
  end
end


fun select-female-adelie(sp-list :: List, sx-list :: List, flip-list :: List) -> List:
  doc: "This function recieves 3 lists of the species, sex, and flipper length of the penguins and checks if they're part of the Adelie species, female or have a flipper length above the average. If so it compares if the elements have a flipper length > 200 and outputs the lists of the elements that fit the criteria"
  avg = average-flipper(flip-list)
  if avg == nothing:
    empty
  else:
    cases (List) sp-list:
      | empty => empty
      | link(fsp, rsp) =>
        cases (List) sx-list:
          | empty => empty
          | link(fsex, rsex) =>
            cases (List) flip-list:
              | empty => empty
              | link(ffl, rfl) =>
                if (string-is-equal(fsp, "Adelie") 
                  or (string-is-equal(fsex, "female")) 
                  or (ffl > avg))
                  and (ffl > 200):
                  link({species: fsp, sex: fsex, flipper: ffl},
                       select-female-adelie(rsp, rsex, rfl))
                else:
                  select-female-adelie(rsp, rsex, rfl)
                end
            end
        end
    end
  end
end
check:
  select-female-adelie(
    [list: "Adelie","Gentoo","Adelie","Chinstrap","Gentoo"],
    [list: "male","female","female","male","female"],
    [list: 181.0, 214.0, 202.0, 210.0, 213.0]
  ) is
  [list:
    {species: "Gentoo", sex: "female", flipper: 214.0},
    {species: "Adelie", sex: "female", flipper: 202.0},
    {species: "Gentoo", sex: "female", flipper: 213.0}
  ]
end

#accumulation
fun lookup(sp :: String, totals :: Number) -> List:
  doc: "looks up given values in accumulator"
  cases (List) totals:
    | empty => nothing
    | link(f, r) =>
      if string-is-equal(f.species, sp):
        f.total
      else:
        lookup(sp, r)
      end
  end
end


fun update-or-insert(sp :: String, mass :: Number, totals :: List) -> List:
  doc: "updates or inserts values"
  cases (List) totals:
    | empty => [list: {species: sp, total: mass}]
    | link(f, r) =>
      if string-is-equal(f.species, sp):
        link({species: sp, total: f.total + mass}, r)
      else:
        link(f, update-or-insert(sp, mass, r))
      end
  end
end

fun accumulate-mass(sp-list :: List, mass-list :: List) -> List:
  doc: "This function takes 2 lists of species and mass, accumulates the numeric mass value and assigns it to its respective species. This is output as a list."
  cases (List) sp-list:
    | empty => empty
    | link(fsp, rsp) =>
      cases (List) mass-list:
        | empty => empty
        | link(fm, rm) =>
          if fm == nothing:
            accumulate-mass(rsp, rm)
          else:
            update-or-insert(fsp, fm, accumulate-mass(rsp, rm))
          end
      end
  end
end
check:
  accumulate-mass(
    [list: "Adelie","Gentoo","Chinstrap","Adelie","Gentoo","Chinstrap"],
    [list: 3750, 4650, 3200, 4600, 4350, 3500]
  )
  is
  [list:
    {species: "Chinstrap", total: 6700},
    {species: "Gentoo", total: 9000},
    {species: "Adelie", total: 8350}
  ]
end
