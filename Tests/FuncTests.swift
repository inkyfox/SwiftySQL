//
//  FuncTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class FuncTests: XCTestCase {
    
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
    
    func testFunc() {
        XCTAssertSQL(SQLFunc("myfunc"), "myfunc()")
        XCTAssertSQL(SQLFunc("myfunc", args: [1, 2, 3]), "myfunc(1, 2, 3)")
        XCTAssertSQL(SQLFunc("myfunc", args: 1, 2, 3), "myfunc(1, 2, 3)")
        XCTAssertSQL(SQLFunc("myfunc", args: SQL.all), "myfunc(*)")
    }
    
    func testCount() {
        XCTAssertSQL(SQL.count(lecture.hours), "COUNT(lec.hours)")
        XCTAssertSQL(SQL.count(.all), "COUNT(*)")
    }

    func testTemplateFuncs() {
        XCTAssertSQL(SQL.avg(lecture.hours), "AVG(lec.hours)")
        XCTAssertSQL(SQL.max(lecture.hours), "MAX(lec.hours)")
        XCTAssertSQL(SQL.min(lecture.hours), "MIN(lec.hours)")
        XCTAssertSQL(SQL.sum(lecture.hours), "SUM(lec.hours)")
        XCTAssertSQL(SQL.total(lecture.hours), "TOTAL(lec.hours)")
        XCTAssertSQL(SQL.abs(lecture.hours), "ABS(lec.hours)")
        XCTAssertSQL(SQL.length(lecture.name), "LENGTH(lec.name)")
        XCTAssertSQL(SQL.lower(lecture.name), "LOWER(lec.name)")
        XCTAssertSQL(SQL.upper(lecture.name), "UPPER(lec.name)")
    }
}
