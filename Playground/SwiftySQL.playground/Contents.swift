//: Playground - noun: a place where people can play

import Cocoa
import SwiftySQL

class Student: SQL.Alias {
    let name = SQL.Column(table: "stu", column: "name")
    let age = SQL.Column(table: "stu", column: "age")
    let attendCount = SQL.Column(table: "stu", column: "attendCount")
    
    init() {
        super.init(SQL.Table("tbl_student"), alias: "stu")
    }
}

class Lecture: SQL.Alias {
    let name = SQL.Column(table: "lec", column: "name")
    let studentName = SQL.Column(table: "lec", column: "name")
    let studentCount = SQL.Column(table: "stu", column: "studentCount")

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

/* Func */
print("--")
debugPrint(SQL.Func("COUNT", args: []))
debugPrint(SQL.Func("COUNT", arg: .asterisk))

debugPrint(SQL.Func("FUNC",
                    args: [1,
                           SQL.select(lecture.studentCount)
                            .from(lecture)
                            .where(21.lt(lecture.studentCount)),
                           2,
                           SQL.Literal.null,
                           "AAA"]))

debugPrint(SQL.count(.asterisk))

debugPrint(SQL.abs(-5))


/* OpExpr */
// binary

print("--")
debugPrint(student.attendCount.eq(lecture.studentCount))
debugPrint(student.attendCount.ne(lecture.studentCount))
debugPrint(
    student.attendCount.ge(SQL.select(lecture.studentCount)
        .from(lecture)
        .where(21.lt(lecture.studentCount))
        .orderBy(lecture.name, .asc)
        .limit(1))
)

debugPrint(student.attendCount.plus(lecture.studentCount))
debugPrint(student.attendCount.minus(lecture.studentCount))
debugPrint(student.attendCount.multiply(lecture.studentCount))
debugPrint(student.attendCount.divide(lecture.studentCount))
debugPrint(student.attendCount.mod(lecture.studentCount))
debugPrint(student.attendCount.is(lecture.studentCount))
debugPrint(student.attendCount.isNot(lecture.studentCount))
debugPrint(student.attendCount.concat(lecture.studentCount))
debugPrint(student.attendCount.bitwiseAnd(lecture.studentCount))
debugPrint(student.attendCount.bitwiseOr(lecture.studentCount))

// unary
print("--")
debugPrint(student.attendCount.isNull())
debugPrint(student.attendCount.NotNull())

debugPrint(SQL.minus(student.attendCount))
debugPrint(SQL
    .minus(SQL.select(lecture.studentCount)
        .from(lecture)
        .where(21.lt(lecture.studentCount))
        .orderBy(lecture.name, .asc)
        .limit(1))
)
debugPrint(SQL.not(student.attendCount))

// combination
print("--")
debugPrint(
    student.name.eq("Yoo")
        .or(student.name.eq("Lee"))
        .and(student.age.lt(lecture.name))
        .and(student.age.lt(lecture.name))
        .and(SQL.not(student.name.eq("Hey"))
            .or(lecture.name.eq("Test")))
        .and(SQL.minus(student.age.lt(lecture.name)))
        .or(SQL.not(lecture.name).eq("Science"))
        .or(student.name.eq("WOW"))
        .and(student.name.eq("Hey")
            .or(lecture.name.eq("Test")))
        .or(lecture.name.eq("Science"))
        .or(student.name.eq("Hey")
            .and(lecture.name.eq("Test")))
)



/* Date */

