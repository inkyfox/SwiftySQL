//
//  TupleTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class TupleTests: XCTestCase {
    
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
    
    func testTuple() {
        XCTAssertSQL(SQLTuple(1), "(1)")
        XCTAssertSQL(SQLTuple(1, 2, 3), "(1, 2, 3)")
        XCTAssertSQL(SQLTuple("ab", "cd", "ef"), "('ab', 'cd', 'ef')")
        XCTAssertSQL(SQLTuple([1, 2, 3]), "(1, 2, 3)")
    }

}
