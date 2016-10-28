//
//  ViewController.swift
//  SwiftySQLExample-macOS
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Cocoa
import SwiftySQL

class Student: SQLAlias {
    
    let table = SQLTable("student")
    
    let id = SQLColumn(table: "s", column: "id")
    let name = SQLColumn(table: "s", column: "name")
    let birth = SQLColumn(table: "s", column: "birth")
    let year = SQLColumn(table: "s", column: "year")
    
    init() {
        super.init(table, alias: "s")
    }
    
}

class Teature: SQLAlias {
    
    let table = SQLTable("teature")
    
    let id = SQLColumn(table: "t", column: "id")
    let name = SQLColumn(table: "t", column: "name")
    let office = SQLColumn(table: "t", column: "office")
    
    init() {
        super.init(table, alias: "t")
    }
    
}

class Lecture: SQLAlias {
    
    let table = SQLTable("lecture")
    
    let id = SQLColumn(table: "l", column: "id")
    let name = SQLColumn(table: "l", column: "name")
    let category = SQLColumn(table: "l", column: "category")
    let teatureID = SQLColumn(table: "l", column: "teature_id")
    let hours = SQLColumn(table: "l", column: "hours")
    
    init() {
        super.init(table, alias: "l")
    }
    
}

class Attending: SQLAlias {
    
    let table = SQLTable("attending")
    
    let studentID = SQLColumn(table: "a", column: "student_id")
    let lectureID = SQLColumn(table: "a", column: "lecture_id")
    
    init() {
        super.init(table, alias: "a")
    }
    
}


class ViewController: NSViewController {

    let student = Student()
    let teature = Teature()
    let lecture = Lecture()
    let attending = Attending()

    override func viewDidLoad() {
        super.viewDidLoad()
     
        buildQueries()
    }

    func buildQueries() {
        
        dump(SQL.delete(from: student))
        dump(SQL.delete(from: teature))
        dump(SQL.delete(from: lecture))
        dump(SQL.delete(from: attending))
        
        dump(SQL.insert(into: student)
            .values(1, "Yoo", Date.of("19770101"), 4)
            .values(2, "Jones", Date.of("19880601"), 3)
            .values(3, "Lucy", Date.of("19920301"), 1)
            .values(4, "Lex", Date.of("19960314"), 1)
            .values(5, "Lee", Date.of("19830313"), 1)
            .values(6, "Steve", Date.of("19991128"), 4)
        )
        
        dump(SQL.insert(into: teature)
            .values(1, "James", "B-102")
            .values(2, "Park", "B-203")
            .values(3, "Mark", "A-1133")
            .values(4, "Choi", "A-1023")
        )
        
        dump(SQL.insert(into: lecture)
            .values(1, "History", "L", 1, 20)
            .values(2, "Physics", "S", 2, 45)
            .values(3, "Computer Science", "S", 2, 42)
            .values(4, "Economics", "E", 3, 15)
            .values(5, "Macroeconomics", "E", 3, 30)
            .values(6, "Sociology", "L", 1, 20)
        )

        dump(SQL.insert(into: attending)
            .values(1, 1)
            .values(1, 3)
            .values(1, 4)
            .values(2, 3)
            .values(2, 6)
            .values(3, 1)
            .values(3, 2)
            .values(3, 3)
            .values(3, 5)
            .values(4, 3)
            .values(5, 2)
            .values(5, 4)
            .values(5, 5)
            .values(5, 6)
        )

    }
    
    func dump(_ query: SQLStringConvertible) {
        print(query.debugDescription + ";")
    }
}

