//
//  OrderTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class OrderTests: XCTestCase {
    
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
    
    func testOrder() {
        XCTAssertSQL(student.name.asc, "stu.name ASC")
        XCTAssertSQL(student.name.desc, "stu.name DESC")
        XCTAssertSQL(SQL.select().from(student).orderBy(student.name.asc),
                     "SELECT * FROM student AS stu ORDER BY stu.name ASC")
    }
    
}
