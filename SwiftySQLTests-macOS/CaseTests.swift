//
//  CaseTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class CaseTests: XCTestCase {
    
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
    
    func testCaseWhenThen() {
        XCTAssertSQL(when(student.grade <= 100, then: 100),
                     "CASE WHEN stu.grade <= 100 THEN 100 END")
        XCTAssertSQL(when(student.grade <= 100, then: student.name),
                     "CASE WHEN stu.grade <= 100 THEN stu.name END")
        XCTAssertSQL(when(student.grade <= 100, then: "text"),
                     "CASE WHEN stu.grade <= 100 THEN \"text\" END")
        XCTAssertSQL(when(student.grade <= 100 || student.id == 5, then: student.name),
                     "CASE WHEN stu.grade <= 100 OR stu.id = 5 THEN stu.name END")
    }
    
    func testCaseWhenThenElse() {
        XCTAssertSQL(when(student.grade <= 100, then: 100).else(200),
                     "CASE WHEN stu.grade <= 100 THEN 100 ELSE 200 END")
    }
    
    func testCaseWhenThenChain() {
        XCTAssertSQL(
            when(student.grade <= 100, then: 100)
                .when(student.grade <= 200, then: 200)
                .when(student.grade <= 300, then: 300)
            ,
            "CASE " +
                "WHEN stu.grade <= 100 THEN 100 " +
                "WHEN stu.grade <= 200 THEN 200 " +
                "WHEN stu.grade <= 300 THEN 300 " +
            "END")
    }
    
    func testCaseWhenThenElseChain() {
        XCTAssertSQL(
            when(student.grade <= 100, then: 100)
                .when(student.grade <= 200, then: 200)
                .when(student.grade <= 300, then: 300)
                .else(400)
            ,
            "CASE " +
                "WHEN stu.grade <= 100 THEN 100 " +
                "WHEN stu.grade <= 200 THEN 200 " +
                "WHEN stu.grade <= 300 THEN 300 " +
                "ELSE 400 " +
            "END")
    }
    
    func testCaseWhenThenElseArray() {
        XCTAssertSQL(
            [when(student.grade <= 100, then: 100),
             when(student.grade <= 200, then: 200),
             when(student.grade <= 300, then: 300)]
                .else(400)
            ,
            "CASE " +
                "WHEN stu.grade <= 100 THEN 100 " +
                "WHEN stu.grade <= 200 THEN 200 " +
                "WHEN stu.grade <= 300 THEN 300 " +
                "ELSE 400 " +
            "END")
    }

}
