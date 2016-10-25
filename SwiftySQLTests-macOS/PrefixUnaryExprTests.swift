//
//  PrefixUnaryExprTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 26..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class PrefixUnaryExprTests: XCTestCase {
    
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
    
    func testNot() {
        XCTAssertSQL(SQL.not(student.id.eq(attending.studentID)), "NOT (stu.id = atd.student_id)")
        XCTAssertSQL(SQL.not(student.name.hasPrefix("Yoo")), "NOT (stu.name LIKE \"Yoo%\")")
        XCTAssertSQL(SQL.not(1), "NOT 1")
    }
    
    func testMinus() {
        XCTAssertSQL(SQL.minus(1), "-1")
        XCTAssertSQL(SQL.minus(student.grade), "-stu.grade")
        XCTAssertSQL(SQL.minus(1).plus(2), "-1 + 2")
        XCTAssertSQL(2.plus(SQL.minus(1)), "2 + -1")
        XCTAssertSQL(2.minus(SQL.minus(1)), "2 - -1")
    }
    
    func testBitwiseNot() {
        XCTAssertSQL(SQL.bitwiseNot(1), "~1")
        XCTAssertSQL(SQL.bitwiseNot(SQL.Hex(0x123)), "~0x123")
    }
    
    func testExists() {
        XCTAssertSQL(
            SQL.exists(SQL.select()
                .from(student)
                .where(student.grade.ge(3))),
            "EXISTS (SELECT * FROM student AS stu WHERE stu.grade >= 3)")
    }
    
    func testNotExists() {
        XCTAssertSQL(
            SQL.notExists(SQL.select()
                .from(student)
                .where(student.grade.ge(3))),
            "NOT EXISTS (SELECT * FROM student AS stu WHERE stu.grade >= 3)")
    }
}
