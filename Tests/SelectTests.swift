//
//  SelectTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 27..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class SelectTests: XCTestCase {
    
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
    
    func testSelect() {
        XCTAssertSQL(SQL.select(), "SELECT *")
        XCTAssertSQL(SQL.select(.all), "SELECT *")
    }

    func testSelectFrom() {
        XCTAssertSQL(SQL.select().from(student),
                     "SELECT * FROM student AS stu")
        XCTAssertSQL(SQL.select(.all).from(student),
                     "SELECT * FROM student AS stu")
        XCTAssertSQL(SQL.select([student.name, student.birth]).from(student),
                     "SELECT stu.name, stu.birth FROM student AS stu")
        XCTAssertSQL(SQL.select(student.name, student.birth).from(student),
                     "SELECT stu.name, stu.birth FROM student AS stu")
        XCTAssertSQL(
            SQL.select(student.name)
                .select(student.birth)
                .select(student.id, student.grade)
                .from(student)
            ,
            "SELECT stu.name, stu.birth, stu.id, stu.grade FROM student AS stu")
        
        XCTAssertSQL(SQL.select(from: student),
                     "SELECT * FROM student AS stu")
        XCTAssertSQL(SQL.select(from: [student, attending]),
                     "SELECT * FROM student AS stu, user.attending AS atd")
        XCTAssertSQL(SQL.select(from: student, attending),
                     "SELECT * FROM student AS stu, user.attending AS atd")

    }

    func testSelectFromWhere() {
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id"
        )
        
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .where(student.id == 100)
            ,
            "SELECT stu.name, stu.birth " +
                "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = 100"
        )
        
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID && attending.lectureID == 100)
            ,
            "SELECT stu.name, stu.birth " +
                "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id AND atd.lecture_id = 100"
        )

    }
    
    func testGroupBy() {
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .groupBy(student.grade)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "GROUP BY stu.grade"
        )
        
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .groupBy([student.grade, student.birth])
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "GROUP BY stu.grade, stu.birth"
        )
        
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .groupBy(student.grade, student.birth)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "GROUP BY stu.grade, stu.birth"
        )
        
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .groupBy(student.grade)
                .groupBy(student.birth)
            ,
            "SELECT stu.name, stu.birth " +
                "FROM student AS stu, user.attending AS atd " +
                "WHERE stu.id = atd.student_id " +
            "GROUP BY stu.grade, stu.birth"
        )
    }
    
    func testHaving() {
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .groupBy(student.birth)
                .having(SQL.sum(student.grade) > 100)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "GROUP BY stu.birth " +
            "HAVING SUM(stu.grade) > 100"
        )
    }
    
    func testOrderBy() {
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .orderBy(student.name)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "ORDER BY stu.name"
        )
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .orderBy(student.name.asc)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "ORDER BY stu.name ASC"
        )
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .orderBy(student.name.desc)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "ORDER BY stu.name DESC"
        )
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .orderBy([student.name.asc, student.birth, student.grade.desc])
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "ORDER BY stu.name ASC, stu.birth, stu.grade DESC"
        )
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .orderBy(student.name.asc, student.birth, student.grade.desc)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "ORDER BY stu.name ASC, stu.birth, stu.grade DESC"
        )
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .orderBy(student.name.asc)
                .orderBy(student.birth)
                .orderBy(student.grade.desc)
                .orderBy(student.id, .asc)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "ORDER BY stu.name ASC, stu.birth, stu.grade DESC, stu.id ASC"
        )
    }
    
    func testLimit() {
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .limit(100)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "LIMIT 100"
        )
        XCTAssertSQL(
            SQL.select(student.name, student.birth)
                .from(student, attending)
                .where(student.id == attending.studentID)
                .limit(100, offset: 120)
            ,
            "SELECT stu.name, stu.birth " +
            "FROM student AS stu, user.attending AS atd " +
            "WHERE stu.id = atd.student_id " +
            "LIMIT 100, 120"
        )
    }
   
}
