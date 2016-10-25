//
//  NativeTypeTests.swift
//  SwiftySQLTests-macOS
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class NativeTypeTests: XCTestCase {
    
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
    
    func testInt() {
        XCTAssertSQLEqual(0, "0")
        XCTAssertSQLEqual(1, "1")
        XCTAssertSQLEqual(-10, "-10")
        XCTAssertSQLEqual(10000, "10000")
    }

    func testFloat() {
        XCTAssertSQLEqual(Float(0), "0")
        XCTAssertSQLEqual(Float(1), "1.0")
        XCTAssertSQLEqual(Float(1.2), "1.2")
        XCTAssertSQLEqual(Float(-1.2), "-1.2")
    }
    
    func testDouble() {
        XCTAssertSQLEqual(Double(1.2), "1.2")
    }
    
    
}
