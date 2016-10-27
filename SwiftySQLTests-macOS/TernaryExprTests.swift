//
//  TernaryExprTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 26..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class TernaryExprTests: XCTestCase {
    
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
    
    func testLike() {
        XCTAssertSQL(lecture.name.like("STU%", escape: "-"),
                     "lec.name LIKE \"STU%\" ESCAPE '-'")
        XCTAssertSQL(lecture.name.notLike("STU%", escape: "-"),
                     "lec.name NOT LIKE \"STU%\" ESCAPE '-'")
    }

    func testBetween() {
        XCTAssertSQL(lecture.id.between(1, and: 100),
                     "lec.id BETWEEN 1 AND 100")
        XCTAssertSQL(lecture.id.notBetween(1, and: 100),
                     "lec.id NOT BETWEEN 1 AND 100")
    }
}
