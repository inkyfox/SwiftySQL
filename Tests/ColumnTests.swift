//
//  ColumnTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class ColumnTests: XCTestCase {
    
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
    
    func testColumns() {
        XCTAssertSQL(
            SQL.select(
                SQLColumn(table: "tbl", column: "name"),
                SQLColumn(table: "tbl2", column: "id"),
                SQLColumn("email")
            )
            ,
            "SELECT tbl.name, tbl2.id, email")
    }
    
    func testColumnOfTable() {
        XCTAssertSQL(
            SQL.select(student.name.of("aliased"))
            .from(student.as("aliased"))
            ,
            "SELECT aliased.name FROM student AS aliased")
    }
    
    func testColumnOfAlias() {
        let sub: SQLAlias = SQLAlias(SQL.select().from(student.table), alias: "sub")
        
        XCTAssertSQL(
            SQL.select(student.name.of(sub))
                .from(sub)
            ,
            "SELECT sub.name FROM (SELECT * FROM student) AS sub")
    }
}
