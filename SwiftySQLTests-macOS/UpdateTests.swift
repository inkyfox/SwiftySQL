//
//  UpdateTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class UpdateTests: XCTestCase {
    
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
    
    func testAction() {
        XCTAssertSQL(SQL.update(student.table).set(student.grade, 100),
                     "UPDATE student SET grade = 100")
        XCTAssertSQL(SQL.update(or: .replace, student.table).set(student.grade, 100),
                     "UPDATE OR REPLACE student SET grade = 100")
        XCTAssertSQL(SQL.update(or: .rollback, student.table).set(student.grade, 100),
                     "UPDATE OR ROLLBACK student SET grade = 100")
        XCTAssertSQL(SQL.update(or: .abort, student.table).set(student.grade, 100),
                     "UPDATE OR ABORT student SET grade = 100")
        XCTAssertSQL(SQL.update(or: .fail, student.table).set(student.grade, 100),
                     "UPDATE OR FAIL student SET grade = 100")
        XCTAssertSQL(SQL.update(or: .ignore, student.table).set(student.grade, 100),
                     "UPDATE OR IGNORE student SET grade = 100")
    }

    func testWhere() {
        XCTAssertSQL(
            SQL.update(student.table)
                .set(student.grade, 100)
                .where(student.id == 10)
            ,
            "UPDATE student SET grade = 100 WHERE id = 10"
        )
    }
    
    func testMultipleSets() {
        XCTAssertSQL(
            SQL.update(student.table)
                .set(student.name, "Yongha")
                .set(student.grade, 100)
                .where(student.id == 10)
            ,
            "UPDATE student SET name = 'Yongha', grade = 100 WHERE id = 10"
        )
    }
}
