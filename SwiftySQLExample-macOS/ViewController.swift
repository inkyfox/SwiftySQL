//
//  ViewController.swift
//  SwiftySQLExample-macOS
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Cocoa
import SwiftySQL

class Student: SQL.Alias {
    let name = SQL.Column(table: "stu", column: "name")
    let age = SQL.Column(table: "stu", column: "age")
    
    init() {
        super.init(SQL.Table("tbl_student"), alias: "stu")
    }
}

class Lecture: SQL.Alias {
    let name = SQL.Column(table: "lec", column: "name")
    let studentName = SQL.Column(table: "lec", column: "name")

    init() {
        super.init(SQL.Table("tbl_lecture"), alias: "lec")
    }
}


class ViewController: NSViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let student = Student()
        let lecture = Lecture()

        let query =
            SQL.select([student.name.as("name"),
                        student.age,
                        lecture.name,
                        "Literal string",
                        1234,
                        SQL.Case([(when: student.age.eq(15),
                                   then: student.age),
                                  (when: SQL.select(student.age)
                                    .from(student)
                                    .where(student.age.le(45))
                                    .eq(5),
                                   then: lecture.studentName)
                                  ],
                                 else: 145),
                        SQL.select(student.age)
                            .from(student)
                            .where(21.ne(student.age))])
                .from([student.as("TABLE"),
                       student
                        .join(lecture)
                        .leftJoin(lecture,
                                  on: student.name.eq(lecture.studentName))
                        .naturalJoin(lecture,
                                     on: student.name.eq(lecture.studentName)),
                       SQL.select(student.age)
                        .from(student)
                        .where(student.age.le(45))
                        .as("ag"),
                       lecture
                    ])
                .where(student.name.eq("Yoo")
                    .or(student.name.eq("Lee"))
                    .and(student.age.lt(lecture.name))
                    .and(student.age.lt(lecture.name))
                    .and(student.name.eq("Hey")
                        .or(lecture.name.eq("Test")))
                    .and(student.age.lt(lecture.name))
                    .or(lecture.name.eq("Science"))
                    .or(student.name.eq("WOW"))
                    .and(student.name.eq("Hey")
                        .or(lecture.name.eq("Test")))
                    .or(lecture.name.eq("Science"))
                    .or(student.name.eq("Hey")
                        .and(lecture.name.eq("Test"))))
                .groupBy(student.age)
                .having(lecture.name.eq("Science"))
                .orderBy([student.name.asc, lecture.name])
                .limit(10, offset: 100)
        
        print(query)
        print("--")
        debugPrint(query)
        
        debugPrint(SQL.count(.asterisk))

    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }


}

