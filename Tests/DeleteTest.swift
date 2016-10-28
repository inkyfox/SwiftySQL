//
//  DeleteTest.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 28..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class DeleteTests: XCTestCase {
    
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
    
    func testDelete() {
        XCTAssertSQL(SQL.delete(from: student), "DELETE FROM student")
    }

    
    func testDeleteWhere() {
        XCTAssertSQL(SQL.delete(from: student).where(student.id == 10),
                     "DELETE FROM student WHERE id = 10")
    }

}
