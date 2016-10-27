//
//  JoinTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class JoinTests: XCTestCase {
    
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
    
    func testJoin() {
        XCTAssertSQL(student.join(attending),
                     "student AS stu JOIN user.attending AS atd")
        XCTAssertSQL(student.join(attending, on: student.id == attending.studentID),
                     "student AS stu JOIN user.attending AS atd ON stu.id = atd.student_id")
    }
    
    func testLeftJoin() {
        XCTAssertSQL(student.leftJoin(attending),
                     "student AS stu LEFT JOIN user.attending AS atd")
        XCTAssertSQL(student.leftJoin(attending, on: student.id == attending.studentID),
                     "student AS stu LEFT JOIN user.attending AS atd ON stu.id = atd.student_id")

        XCTAssertSQL(student.leftOuterJoin(attending),
                     "student AS stu LEFT JOIN user.attending AS atd")
        XCTAssertSQL(student.leftOuterJoin(attending, on: student.id == attending.studentID),
                     "student AS stu LEFT JOIN user.attending AS atd ON stu.id = atd.student_id")
    }
    
    func testCrossJoin() {
        XCTAssertSQL(student.crossJoin(attending),
                     "student AS stu CROSS JOIN user.attending AS atd")
        XCTAssertSQL(student.crossJoin(attending, on: student.id == attending.studentID),
                     "student AS stu CROSS JOIN user.attending AS atd ON stu.id = atd.student_id")
    }
    
    func testNaturalJoin() {
        XCTAssertSQL(student.naturalJoin(attending),
                     "student AS stu NATURAL JOIN user.attending AS atd")
        XCTAssertSQL(student.naturalJoin(attending, on: student.id == attending.studentID),
                     "student AS stu NATURAL JOIN user.attending AS atd ON stu.id = atd.student_id")
    }
    
    func testNaturalLeftJoin() {
        XCTAssertSQL(student.naturalLeftJoin(attending),
                     "student AS stu NATURAL LEFT JOIN user.attending AS atd")
        XCTAssertSQL(student.naturalLeftJoin(attending,
                                             on: student.id == attending.studentID),
                     "student AS stu NATURAL LEFT JOIN user.attending AS atd ON stu.id = atd.student_id")
    }

    func testMultipleJoin() {
        XCTAssertSQL(
            student
                .join(attending, on: student.id == attending.studentID)
                .join(lecture, on: lecture.id == attending.lectureID)
            ,
            "student AS stu " +
            "JOIN user.attending AS atd ON stu.id = atd.student_id " +
            "JOIN lecture AS lec ON lec.id = atd.lecture_id")
    }

}
