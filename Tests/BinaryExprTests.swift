//
//  BinaryExprTests.swift
//  SwiftySQLTests
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 26..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import XCTest

@testable import SwiftySQL

class BinaryExprTests: XCTestCase {
    
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
    
    func testEq() {
        XCTAssertSQL(student.id == attending.studentID, "stu.id = atd.student_id")
        XCTAssertSQL(1234 == attending.studentID, "1234 = atd.student_id")
        XCTAssertSQL(SQL.Hex(0x1234) == attending.studentID, "0x1234 = atd.student_id")
        XCTAssertSQL(student.id == 1234, "stu.id = 1234")
        XCTAssertSQL(
            when(student.name == "Soyul", then: 2).else(1) == 2,
            "CASE WHEN stu.name = 'Soyul' THEN 2 ELSE 1 END = 2")
        XCTAssertSQL(
            attending.studentID ==
                SQL.select(student.id)
                    .from(student)
                    .where(student.name == "Yongha")
                    .limit(1)
            ,
            "atd.student_id = (SELECT stu.id FROM student AS stu WHERE stu.name = 'Yongha' LIMIT 1)")
    }
    
    func testCompares() {
        XCTAssertSQL(student.id > 100, "stu.id > 100")
        XCTAssertSQL(student.id >= 100, "stu.id >= 100")
        XCTAssertSQL(student.id < 100, "stu.id < 100")
        XCTAssertSQL(student.id <= 100, "stu.id <= 100")
        XCTAssertSQL(student.id != 100, "stu.id <> 100")
        //XCTAssertSQL(student.id <> 100, "stu.id <> 100")
    }

    func testAnd() {
        XCTAssertSQL(
            student.name == "Yongha"
                && student.id > 100
                && student.grade <= 3
                && !student.name.hasSuffix("er")
                && exists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id)
                )
                && notExists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id
                            && attending.lectureID == 1900)
                )
                && student.id + 30 < 200
            ,
            "stu.name = 'Yongha' AND " +
            "stu.id > 100 AND " +
            "stu.grade <= 3 AND " +
            "NOT (stu.name LIKE '%er') AND " +
            "EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id) AND " +
            "NOT EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id AND atd.lecture_id = 1900) AND " +
            "stu.id + 30 < 200")
        XCTAssertSQL(
            student.name == "Yongha" && (student.id > 100 && student.grade <= 3)
            ,
            "stu.name = 'Yongha' AND stu.id > 100 AND stu.grade <= 3")
    }
    
    

    func testOr() {
        XCTAssertSQL(
            student.name == "Yongha"
                || student.id > 100
                || student.grade * 2 <= 30
                || !student.name.hasSuffix("er")
                || exists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id)
                )
                || notExists(
                    SQL.select()
                        .from(attending)
                        .where(attending.studentID == student.id &&
                            attending.lectureID == 1900)
                )
                || student.id + 30 < 200
            ,
            "stu.name = 'Yongha' OR " +
            "stu.id > 100 OR " +
            "stu.grade * 2 <= 30 OR " +
            "NOT (stu.name LIKE '%er') OR " +
            "EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id) OR " +
            "NOT EXISTS (SELECT * FROM user.attending AS atd WHERE atd.student_id = stu.id AND atd.lecture_id = 1900) OR " +
            "stu.id + 30 < 200")
        XCTAssertSQL(
            student.name == "Yongha" || (student.id > 100 || student.grade <= 3)
            ,
            "stu.name = 'Yongha' OR stu.id > 100 OR stu.grade <= 3")
    }

    func testAndOrCombination() {
        XCTAssertSQL(
            student.name == "Yongha"
                && (student.id > 100 || student.id < 70)
                && student.grade * 2 <= 30
                && (student.name.hasPrefix("A") || student.name.hasPrefix("B"))
                || student.name.contains("Jones")
            ,
            "stu.name = 'Yongha' AND " +
            "(stu.id > 100 OR stu.id < 70) AND " +
            "stu.grade * 2 <= 30 AND " +
            "(stu.name LIKE 'A%' OR stu.name LIKE 'B%')" +
            " OR " +
            "stu.name LIKE '%Jones%'")
    }

    func testOperators() {
        XCTAssertSQL(student.grade + 0.5, "stu.grade + 0.5")
        XCTAssertSQL(100 + student.grade, "100 + stu.grade")
        XCTAssertSQL(student.id + 100 < attending.studentID, "stu.id + 100 < atd.student_id")

        XCTAssertSQL(student.grade - 0.5, "stu.grade - 0.5")
        XCTAssertSQL(100 - student.grade, "100 - stu.grade")
        XCTAssertSQL(student.id - 100 < attending.studentID, "stu.id - 100 < atd.student_id")
        
        XCTAssertSQL(student.grade * 5, "stu.grade * 5")
        XCTAssertSQL(student.grade / 5, "stu.grade / 5")

        XCTAssertSQL(student.grade % 5, "stu.grade % 5")

        XCTAssertSQL(student.grade & SQL.Hex(0x1013), "stu.grade & 0x1013")
        XCTAssertSQL(student.grade | SQL.Hex(0x1013), "stu.grade | 0x1013")
        
        XCTAssertSQL(student.grade >> 4, "stu.grade >> 4")
        XCTAssertSQL(student.grade << 2, "stu.grade << 2")
    }

    func testIs() {
        XCTAssertSQL(student.id.is(attending.studentID), "stu.id IS atd.student_id")
        XCTAssertSQL(student.id.isNot(attending.studentID), "stu.id IS NOT atd.student_id")

        XCTAssertSQL(
            (student.grade > 0 && student.id != 0).is(attending.studentID != 0)
            ,
            "(stu.grade > 0 AND stu.id <> 0) IS atd.student_id <> 0"
        )
    }

    func testConcat() {
        XCTAssertSQL(
            student.name.concat(" ").concat(student.grade)
            ,
            "stu.name || ' ' || stu.grade"
        )
        XCTAssertSQL(
            "Mrs.".concat(student.name).concat(" ").concat(student.grade)
            ,
            "'Mrs.' || stu.name || ' ' || stu.grade"
        )
    }
    
    func testLike() {
        XCTAssertSQL(student.name.like("Y%"), "stu.name LIKE 'Y%'")
        XCTAssertSQL(student.name.notLike("Y%"), "stu.name NOT LIKE 'Y%'")
        XCTAssertSQL(
            student.name.likeIgnoreCase("Y%")
            ,
            "UPPER(stu.name) LIKE UPPER('Y%')"
        )
        XCTAssertSQL(student.name.notLikeIgnoreCase("Y%"), "UPPER(stu.name) NOT LIKE UPPER('Y%')")
        XCTAssertSQL(
            student.name.contains("Yoo")
            || student.name.hasPrefix("Jones")
            || student.name.hasSuffix("ha")
            ,
            "stu.name LIKE '%Yoo%' OR stu.name LIKE 'Jones%' OR stu.name LIKE '%ha'"
        )
        
        XCTAssertSQL(student.name.containsIgnoreCase("yoo"),
                     "UPPER(stu.name) LIKE UPPER('%yoo%')")
        XCTAssertSQL(student.name.hasPrefixIgnoreCase("yoo"),
                     "UPPER(stu.name) LIKE UPPER('yoo%')")
        XCTAssertSQL(student.name.hasSuffixIgnoreCase("yoo"),
                     "UPPER(stu.name) LIKE UPPER('%yoo')")

    }
    
    func testPreparedStatements() {
        XCTAssertSQL(student.grade == .prepared, "stu.grade = ?")
        XCTAssertSQL(.prepared == student.grade, "? = stu.grade")
        XCTAssertSQL(.prepared == .prepared, "? = ?")
        
        XCTAssertSQL(student.grade > .prepared, "stu.grade > ?")
        XCTAssertSQL(.prepared > student.grade, "? > stu.grade")
        XCTAssertSQL(.prepared > .prepared, "? > ?")
        
        XCTAssertSQL(student.grade >= .prepared, "stu.grade >= ?")
        XCTAssertSQL(.prepared >= student.grade, "? >= stu.grade")
        XCTAssertSQL(.prepared >= .prepared, "? >= ?")
        
        XCTAssertSQL(student.grade < .prepared, "stu.grade < ?")
        XCTAssertSQL(.prepared < student.grade, "? < stu.grade")
        XCTAssertSQL(.prepared < .prepared, "? < ?")
        
        XCTAssertSQL(student.grade <= .prepared, "stu.grade <= ?")
        XCTAssertSQL(.prepared <= student.grade, "? <= stu.grade")
        XCTAssertSQL(.prepared <= .prepared, "? <= ?")
        
        XCTAssertSQL(student.grade != .prepared, "stu.grade <> ?")
        XCTAssertSQL(.prepared != student.grade, "? <> stu.grade")
        XCTAssertSQL(.prepared != .prepared, "? <> ?")
        
        //XCTAssertSQL(student.grade <> .prepared, "stu.grade <> ?")
        //XCTAssertSQL(.prepared <> student.grade, "? <> stu.grade")
        //XCTAssertSQL(.prepared <> .prepared, "? <> ?")
        
        XCTAssertSQL(student.grade + .prepared, "stu.grade + ?")
        XCTAssertSQL(.prepared + student.grade, "? + stu.grade")
        XCTAssertSQL(.prepared + .prepared, "? + ?")
        
        XCTAssertSQL(student.grade - .prepared, "stu.grade - ?")
        XCTAssertSQL(.prepared - student.grade, "? - stu.grade")
        XCTAssertSQL(.prepared - .prepared, "? - ?")
        
        XCTAssertSQL(student.grade * .prepared, "stu.grade * ?")
        XCTAssertSQL(.prepared * student.grade, "? * stu.grade")
        XCTAssertSQL(.prepared * .prepared, "? * ?")
        
        XCTAssertSQL(student.grade / .prepared, "stu.grade / ?")
        XCTAssertSQL(.prepared / student.grade, "? / stu.grade")
        XCTAssertSQL(.prepared / .prepared, "? / ?")
        
        XCTAssertSQL(student.grade % .prepared, "stu.grade % ?")
        XCTAssertSQL(.prepared % student.grade, "? % stu.grade")
        XCTAssertSQL(.prepared % .prepared, "? % ?")
        
        XCTAssertSQL(student.grade & .prepared, "stu.grade & ?")
        XCTAssertSQL(.prepared & student.grade, "? & stu.grade")
        XCTAssertSQL(.prepared & .prepared, "? & ?")
        
        XCTAssertSQL(student.grade | .prepared, "stu.grade | ?")
        XCTAssertSQL(.prepared | student.grade, "? | stu.grade")
        XCTAssertSQL(.prepared | .prepared, "? | ?")
        
        XCTAssertSQL(student.grade >> .prepared, "stu.grade >> ?")
        XCTAssertSQL(.prepared >> student.grade, "? >> stu.grade")
        XCTAssertSQL(.prepared >> .prepared, "? >> ?")
        
        XCTAssertSQL(student.grade << .prepared, "stu.grade << ?")
        XCTAssertSQL(.prepared << student.grade, "? << stu.grade")
        XCTAssertSQL(.prepared << .prepared, "? << ?")
        
        XCTAssertSQL(student.grade.is(.prepared), "stu.grade IS ?")
        XCTAssertSQL(student.grade.isNot(.prepared), "stu.grade IS NOT ?")
        XCTAssertSQL(student.grade.concat(.prepared), "stu.grade || ?")

        XCTAssertSQL(student.name.like(.prepared), "stu.name LIKE ?")
        XCTAssertSQL(student.name.notLike(.prepared), "stu.name NOT LIKE ?")

        XCTAssertSQL(student.name.containsIgnoreCase(.prepared),
                     "UPPER(stu.name) LIKE UPPER('%' || ? || '%')")
        XCTAssertSQL(student.name.hasPrefixIgnoreCase(.prepared),
                     "UPPER(stu.name) LIKE UPPER(? || '%')")
        XCTAssertSQL(student.name.hasSuffixIgnoreCase(.prepared),
                     "UPPER(stu.name) LIKE UPPER('%' || ?)")

    }
    
    func testOperatorPrecedences() {
        XCTAssertSQL(student.grade + 5 + student.id, "stu.grade + 5 + stu.id")
        XCTAssertSQL(student.grade + (5 + student.id), "stu.grade + 5 + stu.id")
        XCTAssertSQL(student.grade * 5 + student.id, "stu.grade * 5 + stu.id")
        XCTAssertSQL(student.grade + 5 * student.id, "stu.grade + 5 * stu.id")
        XCTAssertSQL((student.grade * 5) + student.id, "stu.grade * 5 + stu.id")
        XCTAssertSQL((student.grade + 5) * student.id, "(stu.grade + 5) * stu.id")
        XCTAssertSQL(student.grade * (5 + student.id), "stu.grade * (5 + stu.id)")
        XCTAssertSQL(student.grade + (5 * student.id), "stu.grade + 5 * stu.id")
    }
    
}
