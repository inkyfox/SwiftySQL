//
//  NativeTypeTests.swift
//  SwiftySQLTests
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
        XCTAssertSQL(0, "0")
        XCTAssertSQL(1, "1")
        XCTAssertSQL(-10, "-10")
        XCTAssertSQL(10000, "10000")
    }

    func testFloat() {
        XCTAssertSQL(Float(0), "0.0")
        XCTAssertSQL(Float(1), "1.0")
        XCTAssertSQL(Float(1.2), "1.2")
        XCTAssertSQL(Float(-1.2), "-1.2")
    }
    
    func testDouble() {
        XCTAssertSQL(Double(0), "0.0")
        XCTAssertSQL(Double(1), "1.0")
        XCTAssertSQL(Double(1.2), "1.2")
        XCTAssertSQL(Double(-1.2), "-1.2")
    }

    func testString() {
        XCTAssertSQL("Test", "\"Test\"")
        XCTAssertSQLEqual("Test\nNew Line", "\"Test\nNew Line\"")
        XCTAssertSQL("Test \"quote\"", "\"Test \"quote\"\"")
    }
    
    func testCharacter() {
        XCTAssertSQL(Character("a"), "'a'")
        XCTAssertSQLEqual(Character("\n"), "'\n'")
    }
    
    func testDate() {
        XCTAssertSQL(Date(timeIntervalSince1970: 1000.0), "1000")
        XCTAssertSQL(Date(timeIntervalSince1970: 1400000.0), "1400000")
    }
    
}
