//
//  LiteralTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class LiteralTests: XCTestCase {
    
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
    
    func testKeyword() {
        XCTAssertSQL(SQL.select(SQL.null), "SELECT NULL")
        XCTAssertSQL(SQL.select(SQL.currentDate), "SELECT CURRENT_DATE")
        XCTAssertSQL(SQL.select(SQL.currentTime), "SELECT CURRENT_TIME")
        XCTAssertSQL(SQL.select(SQL.currentTimestamp), "SELECT CURRENT_TIMESTAMP")
    }
    
    func testHex() {
        XCTAssertSQL(SQL.select(SQL.Hex(0x1234)), "SELECT 0x1234")
        XCTAssertSQL(SQL.select(SQL.Hex(0x12345678)), "SELECT 0x12345678")
        XCTAssertSQL(SQL.select(SQL.Hex(1024)), "SELECT 0x400")
        XCTAssertSQL(SQL.select(SQL.Hex(0x12345678)), "SELECT 0x12345678")
    }
    
    func testAsteriskMark() {
        XCTAssertSQL(SQL.select(SQL.all), "SELECT *")
        XCTAssertSQL(SQL.count(SQL.all), "COUNT(*)")
    }
    
    func testPrepared() {
        XCTAssertSQL(student.name == .prepared, "stu.name = ?")
    }
    
}
