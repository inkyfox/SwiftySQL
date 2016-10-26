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
        XCTAssertSQL(!(student.id == attending.studentID), "NOT (stu.id = atd.student_id)")
        XCTAssertSQL(!student.name.hasPrefix("Yoo"), "NOT (stu.name LIKE \"Yoo%\")")
        XCTAssertSQL(!1, "NOT 1")
    }
    
    func testMinus() {
        XCTAssertSQL(-student.grade, "-stu.grade")
        XCTAssertSQL(-1 + 2, "1")
        XCTAssertSQL(2 + -1, "1")
        XCTAssertSQL(-SQL.select(student.grade).from(student).limit(1)
            ,
                     "-(SELECT stu.grade FROM student AS stu LIMIT 1)"
        )
    }
    
    func testBitwiseNot() {
        XCTAssertSQL(~student.grade, "~stu.grade")
        XCTAssertSQL(~SQL.Hex(0x123), "~0x123")
    }
    
    func testExists() {
        XCTAssertSQL(
            SQL.exists(SQL.select()
                .from(student)
                .where(student.grade >= 3)),
            "EXISTS (SELECT * FROM student AS stu WHERE stu.grade >= 3)")
    }
    
    func testNotExists() {
        XCTAssertSQL(
            SQL.notExists(SQL.select()
                .from(student)
                .where(student.grade >= 3)),
            "NOT EXISTS (SELECT * FROM student AS stu WHERE stu.grade >= 3)")
    }
}
