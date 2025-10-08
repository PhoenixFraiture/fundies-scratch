include csv

voter-data =
  load-table: VoterID,DOB,Party,Address,City,County,Postcode
  source: csv-table-url("https://raw.githubusercontent.com/NU-London/LCSCI4207-datasets/refs/heads/main/voters.csv", default-options)
end

fun blank-to-undecided(s :: String) -> String:
  doc: "replaces an empty string with Undecided"
  if s == "":
    "Undecided"
  else:
    s
  end
end
voter-data

undecided-voters = transform-column(voter-data, "Party", blank-to-undecided)

fun normalize-date(c):
  string-replace(c, "/", "-")
end

transform-column(voter-data, "DOB", normalize-date)

fun normalize-postcode1(c):
  block:
  string-to-upper(c)
    if string-char-at(c, 3) == " ":
      string-to-upper(c)
    else if string-char-at(c, 2) == " ":
      d = string-substring(c, 0, 2) + string-substring(c, 2, 6)
      string-to-upper(d)
      else:
      e = string-substring(c, 0, 3) + " " + string-substring(c, 3, 6)
      string-to-upper(e)
    end
  end
end

fun normalize-postcode(c):
  d = string-to-upper(c)
  e = string-replace(d, " ", "")
  f = string-length(e)
  string-substring(e, 0, f - 3) + " " + string-substring( e, f - 3, f)
end

transform-column(voter-data, "Postcode", normalize-postcode)

