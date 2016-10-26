//
//  ViewController.swift
//  SwiftySQLExample-macOS
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

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


class ViewController: NSViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let student = Student()
        let lecture = Lecture()

        let query =
            SQL.select([student.name.as("name"),
                        student.age,
                        lecture.name,
                        "Literal string",
                        1234,
                        SQL.Case([(when: student.age == 15,
                                   then: student.age),
                                  (when: SQL.select(student.age)
                                    .from(student)
                                    .where(student.age <= 45)
                                    == 5,
                                   then: lecture.studentName)
                                  ],
                                 else: 145),
                        SQL.select(student.age)
                            .from(student)
                            .where(21 != student.age)])
                .from([student.as("TABLE"),
                       student
                        .join(lecture)
                        .leftJoin(lecture,
                                  on: student.name == lecture.studentName)
                        .naturalJoin(lecture,
                                     on: student.name == lecture.studentName),
                       SQL.select(student.age)
                        .from(student)
                        .where(student.age <= 45)
                        .as("ag"),
                       lecture
                    ])
                .where(student.name == "Yoo"
                    || student.name == "Lee"
                    && student.age < lecture.name
                    && student.age < lecture.name
                    && (student.name == "Hey"
                        || lecture.name == "Test")
                    && student.age < lecture.name
                    || lecture.name == "Science"
                    || student.name == "WOW"
                    && (student.name == "Hey"
                        || lecture.name == "Test")
                    || lecture.name == "Science"
                    || (student.name == "Hey"
                        && lecture.name == "Test"))
                .groupBy(student.age)
                .having(lecture.name == "Science")
                .orderBy([student.name.asc, lecture.name])
                .limit(10, offset: 100)
        
        print(query)
        print("--")
        debugPrint(query)
        
        debugPrint(SQL.count(.all))

        test(student.name.in(student.table))

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
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


}

