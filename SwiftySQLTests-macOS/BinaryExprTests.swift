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
        XCTAssertSQL(student.id.eq(attending.studentID), "stu.id = atd.student_id")
        XCTAssertSQL(1234.eq(attending.studentID), "1234 = atd.student_id")
        XCTAssertSQL(SQL.Hex(0x1234).eq(attending.studentID), "0x1234 = atd.student_id")
        XCTAssertSQL(student.id.eq(1234), "stu.id = 1234")
        XCTAssertSQL(
            SQL.Case(when: student.name.eq("Soyul"), then: 2, else: 1).eq(2),
            "CASE WHEN stu.name = \"Soyul\" THEN 2 ELSE 1 END = 2")
        XCTAssertSQL(
            attending.studentID
                .eq(SQL.select(student.id)
                    .from(student)
                    .where(student.name.eq("Yongha"))
                    .limit(1))
            ,
            "atd.student_id = (SELECT stu.id FROM student AS stu WHERE stu.name = \"Yongha\" LIMIT 1)")
    }
    
    func testGt() {
        XCTAssertSQL(student.id.gt(100), "stu.id > 100")
    }
    
    func testGe() {
        XCTAssertSQL(student.id.ge(100), "stu.id >= 100")
    }
    
    func testLt() {
        XCTAssertSQL(student.id.lt(100), "stu.id < 100")
    }
    
    func testLe() {
        XCTAssertSQL(student.id.le(100), "stu.id <= 100")
    }
    
    func testNe() {
        XCTAssertSQL(student.id.ne(100), "stu.id <> 100")
    }

    func testAnd() {
        XCTAssertSQL(
            student.name.eq("Yongha")
                .and(student.id.gt(100))
                .and(student.grade.le(3))
                .and(student.id.plus(30).lt(200))
            ,
            "stu.name = \"Yongha\" AND stu.id > 100 AND stu.grade <= 3 AND (stu.id + 30) < 200")
        XCTAssertSQL(
            student.name.eq("Yongha")
                .and(student.id.gt(100)
                    .and(student.grade.le(3)))
            ,
            "stu.name = \"Yongha\" AND stu.id > 100 AND stu.grade <= 3")
    }
    
    func testOr() {
        XCTAssertSQL(
            student.name.eq("Yongha")
                .or(student.id.gt(100))
                .or(student.grade.le(3))
            ,
            "stu.name = \"Yongha\" OR stu.id > 100 OR stu.grade <= 3")
        XCTAssertSQL(
            student.name.eq("Yongha")
                .or(student.id.gt(100)
                    .or(student.grade.le(3)))
            ,
            "stu.name = \"Yongha\" OR stu.id > 100 OR stu.grade <= 3")
    }

    func testAndOrCombination() {
        XCTAssertSQL(
            student.name.eq("Yongha")
                .and(student.id.gt(100).or(student.id.lt(70)))
                .and(student.grade.le(3))
                .and(student.name.hasPrefix("A")
                    .or(student.name.hasPrefix("B")))
                .or(student.name.contains("Jones"))
            
            ,
            "(stu.name = \"Yongha\" AND " +
             "(stu.id > 100 OR stu.id < 70) AND " +
             "stu.grade <= 3 AND " +
             "(stu.name LIKE \"A%\" OR stu.name LIKE \"B%\")" +
            ") OR " +
            "stu.name LIKE \"%Jones%\"")
    }

}
