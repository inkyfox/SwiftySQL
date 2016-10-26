//
//  BinaryExprTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 26..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class BinaryExprTests: XCTestCase {
    
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
    
    func testEq() {
        XCTAssertSQL(student.id == attending.studentID, "stu.id = atd.student_id")
        XCTAssertSQL(1234 == attending.studentID, "1234 = atd.student_id")
        XCTAssertSQL(SQL.Hex(0x1234) == attending.studentID, "0x1234 = atd.student_id")
        XCTAssertSQL(student.id == 1234, "stu.id = 1234")
        XCTAssertSQL(
            SQL.Case(when: student.name == "Soyul", then: 2, else: 1) == 2,
            "CASE WHEN stu.name = \"Soyul\" THEN 2 ELSE 1 END = 2")
        XCTAssertSQL(
            attending.studentID ==
                SQL.select(student.id)
                    .from(student)
                    .where(student.name == "Yongha")
                    .limit(1)
            ,
            "atd.student_id = (SELECT stu.id FROM student AS stu WHERE stu.name = \"Yongha\" LIMIT 1)")
    }
    
    func testGt() {
        XCTAssertSQL(student.id > 100, "stu.id > 100")
    }
    
    func testGe() {
        XCTAssertSQL(student.id >= 100, "stu.id >= 100")
    }
    
    func testLt() {
        XCTAssertSQL(student.id < 100, "stu.id < 100")
    }
    
    func testLe() {
        XCTAssertSQL(student.id <= 100, "stu.id <= 100")
    }
    
    func testNe() {
        XCTAssertSQL(student.id != 100, "stu.id <> 100")
    }

    func testAnd() {
        XCTAssertSQL(
            student.name == "Yongha"
                && student.id > 100
                && student.grade <= 3
                && !student.name.hasSuffix("er")
                && exists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id)
                )
                && notExists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id
                            && attending.lectureID == 1900)
                )
                && student.id + 30 < 200
            ,
            "stu.name = \"Yongha\" AND " +
            "stu.id > 100 AND " +
            "stu.grade <= 3 AND " +
            "NOT (stu.name LIKE \"%er\") AND " +
            "EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id) AND " +
            "NOT EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id AND atd.lecture_id = 1900) AND " +
            "stu.id + 30 < 200")
        XCTAssertSQL(
            student.name == "Yongha" && (student.id > 100 && student.grade <= 3)
            ,
            "stu.name = \"Yongha\" AND stu.id > 100 AND stu.grade <= 3")
    }
    
    

    func testOr() {
        XCTAssertSQL(
            student.name == "Yongha"
                || student.id > 100
                || student.grade <= 3
                || !student.name.hasSuffix("er")
                || exists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id)
                )
                || notExists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id &&
                            attending.lectureID == 1900)
                )
                || student.id + 30 < 200
            ,
            "stu.name = \"Yongha\" OR " +
            "stu.id > 100 OR " +
            "stu.grade <= 3 OR " +
            "NOT (stu.name LIKE \"%er\") OR " +
            "EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id) OR " +
            "NOT EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id AND atd.lecture_id = 1900) OR " +
            "stu.id + 30 < 200")
        XCTAssertSQL(
            student.name == "Yongha" || (student.id > 100 || student.grade <= 3)
            ,
            "stu.name = \"Yongha\" OR stu.id > 100 OR stu.grade <= 3")
    }

    func testAndOrCombination() {
        XCTAssertSQL(
            student.name == "Yongha"
                && (student.id > 100 || student.id < 70)
                && student.grade <= 3
                && (student.name.hasPrefix("A") || student.name.hasPrefix("B"))
                || student.name.contains("Jones")
            ,
            "stu.name = \"Yongha\" AND " +
            "(stu.id > 100 OR stu.id < 70) AND " +
            "stu.grade <= 3 AND " +
            "(stu.name LIKE \"A%\" OR stu.name LIKE \"B%\")" +
            " OR " +
            "stu.name LIKE \"%Jones%\"")
    }

    func testAdd() {
        XCTAssertSQL(student.grade + 0.5, "stu.grade + 0.5")
        XCTAssertSQL(100 + student.grade, "100 + stu.grade")
        XCTAssertSQL(student.id + 100 < attending.studentID, "stu.id + 100 < atd.student_id")
    }
    
    func testSubtract() {
        XCTAssertSQL(student.grade - 0.5, "stu.grade - 0.5")
        XCTAssertSQL(100 - student.grade, "100 - stu.grade")
        XCTAssertSQL(student.id - 100 < attending.studentID, "stu.id - 100 < atd.student_id")
    }

}
