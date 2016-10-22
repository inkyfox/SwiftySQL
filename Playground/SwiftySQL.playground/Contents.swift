//: Playground - noun: a place where people can play

import Cocoa
import SwiftySQL

class Student: SQL.Alias {
    let name = SQL.Column(table: "stu", column: "name")
    let age = SQL.Column(table: "stu", column: "age")
    
    init() {
        super.init(SQL.Table("tbl_student"), alias: "stu")
    }
}

class Lecture: SQL.Alias {
    let name = SQL.Column(table: "lec", column: "name")
    let studentName = SQL.Column(table: "lec", column: "name")
    
    init() {
        super.init(SQL.Table("tbl_lecture"), alias: "lec")
    }
}

let student = Student()
let lecture = Lecture()

let query =
    SQL.select([student.name.as("name"),
                student.age,
                lecture.name,
                "Literal string",
                1234,
                SQL.Case([(when: student.age.eq(15),
                           then: student.age),
                          (when: SQL.select(student.age)
                            .from(student)
                            .where(student.age.le(45))
                            .eq(5),
                           then: lecture.studentName)
                    ],
                         else: 145),
                SQL.select(student.age)
                    .from(student)
                    .where(21.ne(student.age))])
        .from([student.as("T1"),
               student
                .join(lecture)
                .leftJoin(lecture,
                          on: student.name.eq(lecture.studentName))
                .naturalJoin(lecture,
                             on: student.name.eq(lecture.studentName)),
               SQL.select(student.age)
                .from(student)
                .where(student.age.le(45))
                .as("ag"),
               lecture
            ])
        .where(student.name.eq("Yoo")
            .or(student.name.eq("Lee"))
            .and(student.age.lt(lecture.name))
            .and(student.age.lt(lecture.name))
            .and(student.name.eq("Hey")
                .or(lecture.name.eq("Test")))
            .and(student.age.lt(lecture.name))
            .or(lecture.name.eq("Science"))
            .or(student.name.eq("WOW"))
            .and(student.name.eq("Hey")
                .or(lecture.name.eq("Test")))
            .or(lecture.name.eq("Science"))
            .or(student.name.eq("Hey")
                .and(lecture.name.eq("Test"))))
        .groupBy(student.age)
        .having(lecture.name.eq("Science"))
        .orderBy([student.name.asc, lecture.name])
        .limit(10, offset: 100)

debugPrint(query)
print("--")
print(query)
print("--")
let formatted = query.debugDescription.components(separatedBy: "\n")
    .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
    .joined(separator: " ")
    .replacingOccurrences(of: " FROM   ", with: " FROM ")
    .replacingOccurrences(of: " WHERE  ", with: " WHERE ")
    .replacingOccurrences(of: " GROUP  BY ", with: " GROUP BY ")
    .replacingOccurrences(of: " ORDER  BY ", with: " ORDER BY ")
    .replacingOccurrences(of: " LIMIT  ", with: " LIMIT ")
    .replacingOccurrences(of: "( ", with: "(")
    .replacingOccurrences(of: " )", with: ")")
print(formatted)

print("--")
print("SAME: \(query.description == formatted)")
print("--")

print(SQL.Func("COUNT", args: []))
print(SQL.Func("COUNT", args: nil))

