//
//  SwiftSQLTestEnv.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

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

class Student: SQL.Alias {
    
    let table = SQL.Table("student")
    
    let name = SQL.Column(table: "stu", column: "name")
    let birth = SQL.Column(table: "stu", column: "birth")
    let attendCount = SQL.Column(table: "stu", column: "attendCount")
    
    init() {
        super.init(table, alias: "stu")
    }
    
}

class Teature: SQL.Alias {
    
    let table = SQL.Table("teature")
    
    let name = SQL.Column(table: "tea", column: "name")
    let age = SQL.Column(table: "tea", column: "age")
    let attendCount = SQL.Column(table: "stu", column: "attendCount")
    
    init() {
        super.init(table, alias: "stu")
    }
    
}

class Lecture: SQL.Alias {
    
    let table = SQL.Table(schemaName: "user", tableName: "tbl_lecture")
    
    let name = SQL.Column(table: "lec", column: "name")
    let teatureName = SQL.Column(table: "lec", column: "name")
    let studentCount = SQL.Column(table: "lec", column: "studentCount")
    
    init() {
        super.init(table, alias: "lec")
    }
    
}

let student = Student()
let lecture = Lecture()

