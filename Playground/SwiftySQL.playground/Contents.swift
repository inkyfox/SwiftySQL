//: Playground - noun: a place where people can play

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

var student = Student()
var teature = Teature()
var lecture = Lecture()
var attending = Attending()

checkSQL(
    SQL.select(student.name).from(student).where(student.year >= 3 && student.id < 100)
)

checkSQL(
    SQL.select(student.name, student.birth, attending.lectureID)
        .from(student, attending)
        .where(student.id == attending.studentID)
        .orderBy(student.name.asc)
)

checkSQL(
    SQL.select(student.name, student.birth, attending.lectureID)
        .from(student, attending)
        .where(student.id == attending.studentID)
        .orderBy(student.name.asc)
)

checkSQL(
    SQL.select(student.name,
               when(lecture.name.isNotNull, then: lecture.name)
                .else("N/A"),
               when(teature.name.isNotNull, then: teature.name).else("N/A")
               )
        .from(student
            .leftJoin(attending,
                      on: student.id == attending.studentID)
            .leftJoin(lecture, on: lecture.id == attending.lectureID)
            .leftJoin(teature, on: teature.id == lecture.teatureID)
        )
        .where(student.year >= 2
            && student.year <= 3
            && (teature.office.hasPrefix("A")
                || teature.office.isNull)
        )
        .orderBy(student.name.asc)
)

