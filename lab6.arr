use context dcic2024

include csv
include data-source
include lists

student_score = load-table:
  Name,
  Surname,
  Email,
  Score
  source: csv-table-file("students_gate_exam_score.csv", default-options)
  sanitize Score using num-sanitizer
end

student_score

ordered_score = order-by(student_score, "Score", false)

ordered_score.row-n(0)
ordered_score.row-n(1)
ordered_score.row-n(2)

data Student:
  | student(name, surname, score)
end


s1 = student("Ethan", "Gray", 97)
s2 = student("Oscar", "Young", 92)
s3 = student("Adrian", "Bennett", 80)

scores = [list: 97, 92, 80]

fun score-count(score):
  cases (List) score:
    | empty => 0
    | link(f, r) => if f > 90: link(f, r) else: 0 end
  end
end

email-extract = extract Email from student_score end

fun get-domain(emails): 
end

#i ran out of time
  