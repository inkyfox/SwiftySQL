//: Playground - noun: a place where people can play

import Cocoa
import SwiftySQL

class Student: SQLAlias {
    
    let table = SQLTable("student")
    
    let id = SQLColumn(table: "s", column: "id")
    let name = SQLColumn(table: "s", column: "name")
    let birth = SQLColumn(table: "s", column: "birth")
    let year = SQLColumn(table: "s", column: "year")
    
    init() {
        super.init(table, alias: "s")
    }
    
}

class Teature: SQLAlias {
    
    let table = SQLTable("teature")
    
    let id = SQLColumn(table: "t", column: "id")
    let name = SQLColumn(table: "t", column: "name")
    let office = SQLColumn(table: "t", column: "office")
    
    init() {
        super.init(table, alias: "t")
    }
    
}

class Lecture: SQLAlias {
    
    let table = SQLTable("lecture")
    
    let id = SQLColumn(table: "l", column: "id")
    let name = SQLColumn(table: "l", column: "name")
    let category = SQLColumn(table: "l", column: "category")
    let teatureID = SQLColumn(table: "l", column: "teature_id")
    let hours = SQLColumn(table: "l", column: "hours")
    
    init() {
        super.init(table, alias: "l")
    }
    
}

class Attending: SQLAlias {
    
    let table = SQLTable("attending")
    
    let studentID = SQLColumn(table: "a", column: "student_id")
    let lectureID = SQLColumn(table: "a", column: "lecture_id")
    
    init() {
        super.init(table, alias: "a")
    }
    
}

var student = Student()
var teature = Teature()
var lecture = Lecture()
var attending = Attending()

checkSQL(
    SQL.select(student.name).from(student).where(student.year >= 3 && student.id < 100)
)

checkSQL(
    SQL.select(student.name, student.birth, attending.lectureID)
        .from(student, attending)
        .where(student.id == attending.studentID)
        .orderBy(student.name.asc)
)

checkSQL(
    SQL.select(student.name, student.birth, attending.lectureID)
        .from(student, attending)
        .where(student.id == attending.studentID)
        .orderBy(student.name.asc)
)

checkSQL(
    SQL.select(student.name,
               when(lecture.name.isNotNull, then: lecture.name)
                .else("N/A"),
               when(teature.name.isNotNull, then: teature.name).else("N/A")
               )
        .from(student
            .leftJoin(attending,
                      on: student.id == attending.studentID)
            .leftJoin(lecture, on: lecture.id == attending.lectureID)
            .leftJoin(teature, on: teature.id == lecture.teatureID)
        )
        .where(student.year >= 2
            && student.year <= 3
            && (teature.office.hasPrefix("A")
                || teature.office.isNull)
        )
        .orderBy(student.name.asc)
)


//class Student: SQLAlias {
//    let table = SQLTable("tbl_student")
//    
//    let name = SQLColumn(table: "stu", column: "name")
//    let age = SQLColumn(table: "stu", column: "age")
//    let attendCount = SQLColumn(table: "stu", column: "attendCount")
//    
//    init() {
//        super.init(table, alias: "stu")
//    }
//}
//
//class Lecture: SQLAlias {
//    let table = SQLTable(schemaName: "user", tableName: "tbl_lecture")
//    
//    let name = SQLColumn(table: "lec", column: "name")
//    let studentName = SQLColumn(table: "lec", column: "name")
//    let studentCount = SQLColumn(table: "lec", column: "studentCount")
//    
//    init() {
//        super.init(table, alias: "lec")
//    }
//}
//
//let student = Student()
//let lecture = Lecture()
//
//extension String {
//    func replacingOccurrences(of regex: NSRegularExpression, with to: String) -> String {
//        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: characters.count),
//                                       withTemplate: to)
//    }
//}
//
//func unformat(_ query: String) -> String {
//    return
//        query.components(separatedBy: "\n")
//            .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
//            .joined(separator: " ")
//            .replacingOccurrences(of: " FROM   ", with: " FROM ")
//            .replacingOccurrences(of: " GROUP  BY ", with: " GROUP BY ")
//            .replacingOccurrences(of: " ORDER  BY ", with: " ORDER BY ")
//            .replacingOccurrences(of: " LIMIT  ", with: " LIMIT ")
//            .replacingOccurrences(of: try! NSRegularExpression(pattern: " WHERE [ ]*", options: .caseInsensitive),
//                                  with: " WHERE ")
//            .replacingOccurrences(of: try! NSRegularExpression(pattern: " VALUES [ ]*", options: .caseInsensitive),
//                                  with: " VALUES ")
//            .replacingOccurrences(of: try! NSRegularExpression(pattern: " SET [ ]*", options: .caseInsensitive),
//                                  with: " SET ")
//            .replacingOccurrences(of: "( ", with: "(")
//            .replacingOccurrences(of: " )", with: ")")
//}
//
//extension SQLStringConvertible {
//    func sql(by generator: SQLGenerator) -> String {
//        return (self as? SQLQueryType)?.query(by: generator) ??
//            self.sqlString(forRead: true, by: generator)
//    }
//
//    func formattedSQL(withIndent indent: Int, by generator: SQLGenerator) -> String {
//        return (self as? SQLQueryType)?.formattedQuery(withIndent: indent, by: generator) ??
//            self.formattedSQLString(forRead: true,
//                                    withIndent: indent,
//                                    by: generator)
//    }
//}
//
//func test(_ sql: SQLStringConvertible) {
//    let generator = SQLGenerator.default
//    let query = sql.sql(by: generator)
//    let formatted = sql.formattedSQL(withIndent: 0, by: generator)
//    let passed = query == unformat(formatted)
//    let result = passed ? "[Passed] " : "[Failed] "
//    let indent = result.characters.count
//    if passed {
//        print("\(result)\(sql.formattedSQL(withIndent: indent, by: generator))")
//    } else {
//        print("\(result)\(sql.formattedSQL(withIndent: indent, by: generator))")
//        print("    \(query)")
//        print("    \(unformat(formatted))")
//    }
//}
//
//let query =
//    SQL.select(student.name.as("name"),
//               student.age,
//               lecture.name,
//               "Literal string",
//               1234,
////               SQLCase([(when: student.age == 15,
////                          then: student.age),
////                         (when: SQL.select(student.age)
////                            .from(student)
////                            .where(student.age <= 45)
////                            == 5,
////                          then: lecture.studentName)
////                ],
////                        else: 145),
//               SQL.select(student.age)
//                .from(student)
//                .where(21 != student.age)
//        )
//        .from(student.as("T1"),
//              student
//                .join(lecture)
//                .leftJoin(lecture,
//                          on: student.name == lecture.studentName)
//                .naturalJoin(lecture,
//                             on: student.name == lecture.studentName),
//              SQL.select(student.age)
//                .from(student)
//                .where(student.age < 45)
//                .as("ag"),
//              lecture
//        )
//        .where(student.name == "Yoo"
//            || student.name == "Lee"
//            && student.age < lecture.name
//            && student.age < lecture.name
//            && (student.name == "Hey"
//                || lecture.name == "Test")
//            && student.age < lecture.name
//            || lecture.name == "Science"
//            || student.name == "WOW"
//            && (student.name == "Hey"
//                || lecture.name == "Test")
//            || lecture.name == "Science"
//            || (student.name == "Hey"
//                && lecture.name == "Test"))
//        .groupBy(student.age)
//        .having(lecture.name == "Science")
//        .orderBy([student.name.asc, lecture.name])
//        .limit(10, offset: 100)
//
//debugPrint(query)
//print("--")
//print(query)
//print("--")
//let unformatted =
//    query.debugDescription.components(separatedBy: "\n")
//        .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
//        .joined(separator: " ")
//        .replacingOccurrences(of: " FROM   ", with: " FROM ")
//        .replacingOccurrences(of: " WHERE  ", with: " WHERE ")
//        .replacingOccurrences(of: " GROUP  BY ", with: " GROUP BY ")
//        .replacingOccurrences(of: " ORDER  BY ", with: " ORDER BY ")
//        .replacingOccurrences(of: " LIMIT  ", with: " LIMIT ")
//        .replacingOccurrences(of: "( ", with: "(")
//        .replacingOccurrences(of: " )", with: ")")
//print(unformatted)
//
//print("--")
//print("SAME: \(query.description == unformatted)")
//
///* literal */
//
//test(SQL.select(1, 2, "string", Character("c"), Date()))
//
///* Func */
//print("--")
//
//test(SQLFunc("FUNC",
//              args: [1,
//                     SQL.select(lecture.studentCount)
//                        .from(lecture)
//                        .where(21 < lecture.studentCount),
//                     2,
//                     SQL.null,
//                     "AAA"]))
//
//test(SQL.count(.all))
//
//test(SQL.abs(-5))
//
//
///* OpExpr */
//// unary
//print("--")
//test(student.attendCount.isNull)
//test(student.attendCount.isNotNull)
//
//test(-student.attendCount)
//test(-SQL.select(lecture.studentCount)
//    .from(lecture)
//    .where(21 < lecture.studentCount)
//    .orderBy(lecture.name, .asc)
//    .limit(1)
//)
//test(!student.attendCount)
//
//test(SQL
//    .exists(SQL.select(lecture.studentCount)
//        .from(lecture)
//        .where(21 < lecture.studentCount)
//        .orderBy(lecture.name, .asc)
//        .limit(1))
//)
//
//// binary
//
//print("--")
//test(student.attendCount == lecture.studentCount)
//test(student.attendCount != lecture.studentCount)
//test(
//    student.attendCount >=
//        SQL.select(lecture.studentCount)
//            .from(lecture)
//            .where(21 < lecture.studentCount)
//            .orderBy(lecture.name, .asc)
//            .limit(1)
//)
//
//test(student.attendCount + lecture.studentCount)
//test(student.attendCount - lecture.studentCount)
//test(student.attendCount * lecture.studentCount)
//test(student.attendCount / lecture.studentCount)
//test(student.attendCount % lecture.studentCount)
//test(student.attendCount.is(lecture.studentCount))
//test(student.attendCount.isNot(lecture.studentCount))
//test(student.attendCount.concat(lecture.studentCount))
//test(student.attendCount & lecture.studentCount)
//test(student.attendCount | lecture.studentCount)
//
//test(student.name.like("%JONE%"))
//test(student.name.notLike("%JONE%"))
//test(student.name.likeIgnoreCase("%JONE%"))
//test(student.name.notLikeIgnoreCase("%JONE%"))
//test(student.name.contains("abc"))
//test(student.name.hasPrefix("abc"))
//test(student.name.hasSuffix("abc"))
//
//print("--")
//test(student.attendCount == .prepared)
//test(student.attendCount * .prepared)
//test(student.name.like(.prepared))
//test(student.name.notLike(.prepared))
//
//// ternary
//print("--")
//test(student.name.like("%JONE%", escape: "|"))
//test(student.name.between(Character("a"), and: Character("z")))
//test(student.name.notBetween(1, and: 100))
//
//test(student.name
//    .in(SQL.select(lecture.studentCount)
//        .from(lecture)
//        .where(21 < lecture.studentCount))
//)
//
//test(student.name.in(student.table))
//
//// tuple
//
//test(student.name.in(SQLTuple("a", "b", 1)))
//
//// combination
//print("--")
//test(
//    student.name == "Yoo"
//        || student.name == "Lee"
//        && student.age < lecture.name
//        && student.age < lecture.name
//        && (student.name == "Hey"
//            || lecture.name == "Test")
//        && student.age < lecture.name
//        || lecture.name == "Science"
//        || student.name == "WOW"
//        && (student.name == "Hey"
//            || lecture.name == "Test")
//        || lecture.name == "Science"
//        || (student.name == "Hey"
//            && lecture.name == "Test")
//)
//
///* Date */
//
//
///* Insert */
//
//test(
//    SQL.insert(into: student.table)
//        .columns(student.name, student.age, student.attendCount)
//        .values("Yongha", "40", "1")
//        .values("Soyul", "5", "0")
//)
//
//test(
//    SQL.insert(or: .replace, into: student.table)
//        .columns(student.name, student.age, student.attendCount)
//        .values("Yongha", "40", "1")
//        .values("Soyul", "5", "0")
//)
//
//test(
//    SQL.insert(into: student.table)
//        .columns(student.name, student.age, student.attendCount)
//        .select(SQL.select(lecture.studentCount)
//            .from(lecture)
//            .where(21 < lecture.studentCount))
//)
//
//test(
//    SQL.insert(into: student.table)
//        .columns(student.name, student.age, student.attendCount)
//)
//
///* Update */
//
//test(
//    SQL.update(student.table)
//        .set(student.name, "Lee")
//        .set([student.name, student.age],
//             ["Lee", 30])
//        .set([student.name, student.age],
//             SQL.select(lecture.studentName, lecture.studentCount)
//                .from(lecture)
//                .where(21 < lecture.studentCount))
//        .set([student.name, student.age],
//             [
//                SQL.select(lecture.studentName)
//                    .from(lecture)
//                    .where(21 < lecture.studentCount),
//                SQL.select(lecture.studentCount)
//                    .from(lecture)
//                    .where(21 < lecture.studentCount),
//            ])
//        .where(21 < lecture.studentCount)
//)
//
///* Delete */
//
//test(
//    SQL.delete(from: student.table)
//        .where(student.name == "Yoo"
//            || student.name == "Lee"
//            && student.age < lecture.name
//            && student.age < lecture.name
//            && (student.name == "Hey"
//                || lecture.name == "Test")
//            && student.age < lecture.name
//            || lecture.name == "Science"
//            || student.name == "WOW"
//            && (student.name == "Hey"
//                || lecture.name == "Test")
//            || lecture.name == "Science"
//            || (student.name == "Hey"
//                && lecture.name == "Test"))
//)
//
//test(
//    SQL.delete(from: student.table)
//        .where(student.name == "Yoo"
//            || student.name == "Lee"
//            && student.age < lecture.name
//            && student.age < lecture.name
//            && (student.name == "Hey"
//                || lecture.name == "Test")
//            && student.age < lecture.name
//            || lecture.name == "Science"
//            || student.name == "WOW"
//            && (student.name == "Hey"
//                || lecture.name == "Test")
//            || lecture.name == "Science"
//            || (student.name == "Hey"
//                && lecture.name == "Test"))
//)
//
//
//test(~SQLHex(0x123))
//
//test(student.age + student.age)
//
//test(student.age + 100)
//
//test("ab" + student.age)
//
//test(!student.age)
//
//
//test(student.age == 100)
//
//test(student.age == .prepared)
//
//test(student.age > 100)
//
//test(student.age > .prepared)
//
//test(student.age + .prepared == .prepared)
//
//test(student.age >> 2)
//test(student.age << 2)
//test(student.age >> .prepared)
//
//test(.prepared == 1)
//test(.prepared + 1)
//test(.prepared + .prepared == 2)
//test(.prepared + 2 == .prepared)
//
////test(student.age <> .prepared)
//
////test(
////    ((student.age > 100) => 100)
////)
////test(
////    ((student.age > 100) => 100).else(200)
////)
////test(
////    [(student.age < 100) => 100,
////     (student.age < 200) => 200,
////     (student.age < 300) => 300]
////    .else(400)
////)
//
////case(when(student.age > 100, then: 100), else: 200))
//
//test(
//    when(student.age <= 100, then: 100)
//)
//
//test(
//    when(student.age <= 100, then: 100).else(200)
//)
//
//test(
//    when(student.age <= 100, then: 100)
//        .when(student.age <= 200, then: 200)
//        .when(student.age <= 300, then: 300)
//)
//
//test(
//    when(student.age <= 100, then: 100)
//        .when(student.age <= 200, then: 200)
//        .when(student.age <= 300, then: 300)
//        .else(400)
//)
//
//test(
//    [when(student.age <= 100, then: 100),
//     when(student.age <= 200, then: 200),
//     when(student.age <= 300, then: 300)]
//        .else(400)
//)

