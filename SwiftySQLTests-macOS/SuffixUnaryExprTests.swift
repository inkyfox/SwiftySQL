//
//  SuffixUnaryExprTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 26..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

import XCTest

@testable import SwiftySQL

class SuffixUnaryExprTests: XCTestCase {
    
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
    
    func testIsNull() {
        XCTAssertSQL(student.birth.isNull(), "stu.birth ISNULL")
        XCTAssertSQL(
            SQL.select(student.birth).from(student).where(student.id.eq(1234))
            .isNull()
            ,
            "(SELECT stu.birth FROM student AS stu WHERE stu.id = 1234) ISNULL"
        )
        XCTAssertSQL("test".isNull(), "\"test\" ISNULL")
        XCTAssertSQL(
            SQL.Case(when: student.grade.lt(2),
                     then: student.id,
                     else: SQL.Keyword.null)
            .isNull()
            ,
            "CASE WHEN stu.grade < 2 THEN stu.id ELSE NULL END ISNULL"
        )
    }
    
    func testIsNotNull() {
        XCTAssertSQL(student.birth.isNotNull(), "stu.birth NOTNULL")
        XCTAssertSQL(
            SQL.select(student.birth).from(student).where(student.id.eq(1234))
                .isNotNull(),
            "(SELECT stu.birth FROM student AS stu WHERE stu.id = 1234) NOTNULL")
        XCTAssertSQL("test".isNotNull(), "\"test\" NOTNULL")
        XCTAssertSQL(
            SQL.Case(when: student.grade.lt(2),
                     then: student.id,
                     else: SQL.Keyword.null)
                .isNotNull()
            ,
            "CASE WHEN stu.grade < 2 THEN stu.id ELSE NULL END NOTNULL"
        )
    }
}
