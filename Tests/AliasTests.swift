//
//  AliasTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class AliasTests: XCTestCase {
    
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
    
    func testAlias() {
        XCTAssertSQL(
            SQLAlias(SQL.select().from(student.table), alias: "sub"),
            "(SELECT * FROM student) AS sub")
        XCTAssertSQL(SQLAlias(student.name, alias: "name"), "stu.name AS name")
        XCTAssertSQL(SQLAlias(1, alias: "count"), "1 AS count")
    }

    func testAliasAs() {
        XCTAssertSQL(student.as("als"), "student AS als")
    }
    
    func testAliasableAs() {
        XCTAssertSQL((student.grade * 3).as("adjusted"), "(stu.grade * 3) AS adjusted")
    }
}
