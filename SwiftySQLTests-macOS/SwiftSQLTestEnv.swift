//
//  SwiftSQLTestEnv.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation
import XCTest

@testable import SwiftySQL

extension String {
    func replacingOccurrences(of regex: NSRegularExpression, with to: String) -> String {
        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: characters.count),
                                              withTemplate: to)
    }
}

func unformat(_ query: String) -> String {
    return
        query.components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
            .joined(separator: " ")
            .replacingOccurrences(of: " FROM   ", with: " FROM ")
            .replacingOccurrences(of: " GROUP  BY ", with: " GROUP BY ")
            .replacingOccurrences(of: " ORDER  BY ", with: " ORDER BY ")
            .replacingOccurrences(of: " LIMIT  ", with: " LIMIT ")
            .replacingOccurrences(of: try! NSRegularExpression(pattern: " WHERE [ ]*", options: .caseInsensitive),
                                  with: " WHERE ")
            .replacingOccurrences(of: try! NSRegularExpression(pattern: " VALUES [ ]*", options: .caseInsensitive),
                                  with: " VALUES ")
            .replacingOccurrences(of: try! NSRegularExpression(pattern: " SET [ ]*", options: .caseInsensitive),
                                  with: " SET ")
            .replacingOccurrences(of: "( ", with: "(")
            .replacingOccurrences(of: " )", with: ")")
}

extension SQLStringConvertible {
    func sql(by generator: SQLGenerator) -> String {
        return (self as? SQLQueryType)?.query(by: generator) ?? self.sqlString(by: generator)
    }
    
    func formattedSQL(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return (self as? SQLQueryType)?.formattedQuery(withIndent: indent, by: generator) ??
            self.formattedSQLString(withIndent: indent, by: generator)
    }
}

extension XCTestCase {
    func XCTAssertSQLFormat(_ sql: SQLStringConvertible,
                     file: String = #file, line: UInt = #line) {
        let generator = SQLGenerator.default
        let query = sql.sql(by: generator)
        let formatted = sql.formattedSQL(withIndent: 0, by: generator)
        let unformatted = unformat(formatted)
        if query != unformatted {
            recordFailure(withDescription: "Formatted SQL != Unformatted SQL:\n[\(query)]\n!=\n[\(unformatted)]",
                inFile: file, atLine: line, expected: true)
        }
    }

    func XCTAssertSQLEqual(_ sql: SQLStringConvertible, _ string: String,
                           file: String = #file, line: UInt = #line) {
        let query = sql.sql(by: SQLGenerator.default)
        if query != string {
            recordFailure(withDescription: "SQL Equal failed:\n\(query)\n!=\n\(string)",
                inFile: file, atLine: line, expected: true)
        }
    }
    
    func XCTAssertSQL(_ sql: SQLStringConvertible, _ string: String,
                           file: String = #file, line: UInt = #line) {
        
        XCTAssertSQLFormat(sql, file: file, line: line)
        XCTAssertSQLEqual(sql, string, file: file, line: line)
    }
}

class Student: SQL.Alias {
    
    let table = SQL.Table("student")
    
    let id = SQL.Column(table: "stu", column: "id")
    let name = SQL.Column(table: "stu", column: "name")
    let birth = SQL.Column(table: "stu", column: "birth")
    let grade = SQL.Column(table: "stu", column: "grade")
    
    init() {
        super.init(table, alias: "stu")
    }
    
}

class Teature: SQL.Alias {
    
    let table = SQL.Table("teature")
    
    let id = SQL.Column(table: "tea", column: "id")
    let name = SQL.Column(table: "tea", column: "name")
    let office = SQL.Column(table: "tea", column: "office")
    
    init() {
        super.init(table, alias: "tea")
    }
    
}

class Lecture: SQL.Alias {
    
    let table = SQL.Table("lecture")
    
    let id = SQL.Column(table: "lec", column: "id")
    let name = SQL.Column(table: "lec", column: "name")
    let category = SQL.Column(table: "lec", column: "category")
    let teatureID = SQL.Column(table: "lec", column: "teature_id")
    let hours = SQL.Column(table: "lec", column: "hours")
    
    init() {
        super.init(table, alias: "lec")
    }
    
}

class Attending: SQL.Alias {
    
    let table = SQL.Table(schemaName: "user", tableName: "attending")
    
    let studentID = SQL.Column(table: "atd", column: "student_id")
    let lectureID = SQL.Column(table: "atd", column: "lecture_id")
    
    init() {
        super.init(table, alias: "atd")
    }

}

var student: Student!
var teature: Teature!
var lecture: Lecture!
var attending: Attending!



