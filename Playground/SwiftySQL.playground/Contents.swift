//: Playground - noun: a place where people can play

import Cocoa
import SwiftySQL

class Student: SQL.Alias {
    let table = SQL.Table("tbl_student")
    
    let name = SQL.Column(table: "stu", column: "name")
    let age = SQL.Column(table: "stu", column: "age")
    let attendCount = SQL.Column(table: "stu", column: "attendCount")
    
    init() {
        super.init(table, alias: "stu")
    }
}

class Lecture: SQL.Alias {
    let table = SQL.Table(schemaName: "user", tableName: "tbl_lecture")
    
    let name = SQL.Column(table: "lec", column: "name")
    let studentName = SQL.Column(table: "lec", column: "name")
    let studentCount = SQL.Column(table: "stu", column: "studentCount")
    
    init() {
        super.init(table, alias: "lec")
    }
}

let student = Student()
let lecture = Lecture()

func unformat(_ query: String) -> String {
    return query.components(separatedBy: "\n")
        .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
        .joined(separator: " ")
        .replacingOccurrences(of: " FROM   ", with: " FROM ")
        .replacingOccurrences(of: " WHERE  ", with: " WHERE ")
        .replacingOccurrences(of: " GROUP  BY ", with: " GROUP BY ")
        .replacingOccurrences(of: " ORDER  BY ", with: " ORDER BY ")
        .replacingOccurrences(of: " LIMIT  ", with: " LIMIT ")
        .replacingOccurrences(of: "( ", with: "(")
        .replacingOccurrences(of: " )", with: ")")
}

func test(_ sql: SQLStringConvertible) {
    let generator = SQLGenerator.default
    let query = sql.sqlString(by: generator)
    let formatted = sql.formattedSQLString(withIndent: 0, by: generator)
    let passed = query == unformat(formatted)
    let result = passed ? "[Passed] " : "[Failed] "
    let indent = result.characters.count
    if passed {
        print("\(result)\(sql.formattedSQLString(withIndent: indent, by: generator))")
    } else {
        print("\(result)\(sql.formattedSQLString(withIndent: indent, by: generator))")
        print("    \(query)")
        print("    \(unformat(formatted))")
    }
}

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
test(SQL.Func("COUNT", args: []))
test(SQL.Func("COUNT", arg: .asterisk))

test(SQL.Func("FUNC",
              args: [1,
                     SQL.select(lecture.studentCount)
                        .from(lecture)
                        .where(21.lt(lecture.studentCount)),
                     2,
                     SQL.Literal.null,
                     "AAA"]))

test(SQL.count(.asterisk))

test(SQL.abs(-5))


/* OpExpr */
// binary

print("--")
test(student.attendCount.eq(lecture.studentCount))
test(student.attendCount.ne(lecture.studentCount))
test(
    student.attendCount.ge(SQL.select(lecture.studentCount)
        .from(lecture)
        .where(21.lt(lecture.studentCount))
        .orderBy(lecture.name, .asc)
        .limit(1))
)

test(student.attendCount.plus(lecture.studentCount))
test(student.attendCount.minus(lecture.studentCount))
test(student.attendCount.multiply(lecture.studentCount))
test(student.attendCount.divide(lecture.studentCount))
test(student.attendCount.mod(lecture.studentCount))
test(student.attendCount.is(lecture.studentCount))
test(student.attendCount.isNot(lecture.studentCount))
test(student.attendCount.concat(lecture.studentCount))
test(student.attendCount.bitwiseAnd(lecture.studentCount))
test(student.attendCount.bitwiseOr(lecture.studentCount))

// unary
print("--")
test(student.attendCount.isNull())
test(student.attendCount.isNotNull())

test(SQL.minus(student.attendCount))
test(SQL
    .minus(SQL.select(lecture.studentCount)
        .from(lecture)
        .where(21.lt(lecture.studentCount))
        .orderBy(lecture.name, .asc)
        .limit(1))
)
test(SQL.not(student.attendCount))

test(student.name.like("%JONE%"))
test(student.name.notLike("%JONE%"))
test(student.name.like("%JONE%", escape: "|"))
test(student.name.likeIgnoreCase("%JONE%"))
test(student.name.notLikeIgnoreCase("%JONE%"))
test(student.name.contains("abc"))
test(student.name.hasPrefix("abc"))
test(student.name.hasSuffix("abc"))

test(student.name.between(Character("a"), and: Character("z")))
test(student.name.notBetween(1, and: 100))

test(student.name
    .in(SQL.select(lecture.studentCount)
        .from(lecture)
        .where(21.lt(lecture.studentCount)))
)

test(student.name.in(student.table))

// combination
print("--")
test(
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

