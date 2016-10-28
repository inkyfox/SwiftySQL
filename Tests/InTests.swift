//
//  InTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class InTests: XCTestCase {
    
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
    
    func testIn() {
        XCTAssertSQL(student.name.in("a", "b", "c"), "stu.name IN ('a', 'b', 'c')")
        XCTAssertSQL(student.grade.in(100, 200), "stu.grade IN (100, 200)")
        XCTAssertSQL(
            student.id.in(SQL.select(attending.studentID).from(attending).where(attending.lectureID == 1024))
            ,
            "stu.id IN (SELECT atd.student_id FROM user.attending AS atd WHERE atd.lecture_id = 1024)")
    }
    
    func testNotIn() {
        XCTAssertSQL(student.name.notIn("a", "b", "c"), "stu.name NOT IN ('a', 'b', 'c')")
        XCTAssertSQL(student.grade.notIn(100, 200), "stu.grade NOT IN (100, 200)")
        XCTAssertSQL(
            student.id.notIn(SQL.select(attending.studentID).from(attending).where(attending.lectureID == 1024))
            ,
            "stu.id NOT IN (SELECT atd.student_id FROM user.attending AS atd WHERE atd.lecture_id = 1024)")
    }
}
