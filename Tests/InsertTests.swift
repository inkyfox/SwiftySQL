//
//  InsertTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class InsertTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        
        student = Student()
        teature = Teature()
        lecture = Lecture()
        attending = Attending()
    }
    
    override func tearDown() {
        super.tearDown()
        
        student = nil
        teature = nil
        lecture = nil
        attending = nil
    }
    
    func testActions() {
        XCTAssertSQL(SQL.insert(into: student),
                     "INSERT INTO student DEFAULT VALUES")
        XCTAssertSQL(SQL.replace(into: student),
                     "REPLACE INTO student DEFAULT VALUES")
        XCTAssertSQL(SQL.insert(or: .replace, into: student),
                     "INSERT OR REPLACE INTO student DEFAULT VALUES")
        XCTAssertSQL(SQL.insert(or: .rollback, into: student),
                     "INSERT OR ROLLBACK INTO student DEFAULT VALUES")
        XCTAssertSQL(SQL.insert(or: .abort, into: student),
                     "INSERT OR ABORT INTO student DEFAULT VALUES")
        XCTAssertSQL(SQL.insert(or: .fail, into: student),
                     "INSERT OR FAIL INTO student DEFAULT VALUES")
        XCTAssertSQL(SQL.insert(or: .ignore, into: student),
                     "INSERT OR IGNORE INTO student DEFAULT VALUES")
    }
   
    func testInsertValues() {
        XCTAssertSQL(
            SQL.insert(into: student)
            .columns([student.id, student.name])
            .values([10, "Yongha"])
            ,
            "INSERT INTO student " +
            "(id, name) " +
            "VALUES (10, 'Yongha')"
        )
        XCTAssertSQL(
            SQL.insert(into: student)
                .columns(student.id, student.name)
                .values(10, "Yongha")
            ,
            "INSERT INTO student " +
            "(id, name) " +
            "VALUES (10, 'Yongha')"
        )
        XCTAssertSQL(
            SQL.insert(into: student)
                .columns(student.id, student.name)
                .values(SQL.Tuple(10, "Yongha"))
            ,
            "INSERT INTO student " +
            "(id, name) " +
            "VALUES (10, 'Yongha')"
        )
        XCTAssertSQL(
            SQL.insert(into: student)
                .columns(student.id, student.name)
                .values(.prepared)
            ,
            "INSERT INTO student " +
            "(id, name) " +
            "VALUES (?, ?)"
        )
    }
    
    func testInsertSelect() {
        XCTAssertSQL(
            SQL.insert(into: student)
                .columns(student.id, student.name)
                .select(SQL.select(100, "Indy"))
            ,
            "INSERT INTO student (id, name) SELECT 100, 'Indy'"
        )
    }
 
    func testInsertAll() {
        let f = DateFormatter()
        f.dateFormat = "yyyy-MM-dd"
        
        XCTAssertSQL(
            SQL.insert(into: student)
                .values(100, "Jones", f.date(from: "1977-08-29")!, 100)
            ,
            "INSERT INTO student VALUES (100, 'Jones', \(Int(f.date(from: "1977-08-29")!.timeIntervalSince1970)), 100)"
        )
    }
    
    func testInsertMultipleValues() {
        XCTAssertSQL(
            SQL.insert(into: student)
                .columns([student.id, student.name])
                .values(10, "Yongha")
                .values(20, "Soyul")
                .values(30, "Jones")
            ,
            "INSERT INTO student " +
            "(id, name) " +
            "VALUES " +
            "(10, 'Yongha'), " +
            "(20, 'Soyul'), " +
            "(30, 'Jones')"
        )
    }
}
