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

var s = Student()
var t = Teature()
var l = Lecture()
var a = Attending()

/* Query examples */

checkSQL(
    SQL.select(s.name).from(s).where(s.year >= 3 && s.id < 100)
)

checkSQL(
    SQL.select(s.name, s.birth, a.lectureID)
        .from(s, a)
        .where(s.id == a.studentID)
        .orderBy(s.name.asc)
)

checkSQL(
    SQL.select(s.name, s.birth, a.lectureID)
        .from(s, a)
        .where(s.id == a.studentID)
        .orderBy(s.name.asc)
)

checkSQL(
    SQL.select(s.name,
               when(l.name.isNotNull, then: l.name)
                .else("N/A"),
               when(t.name.isNotNull, then: t.name).else("N/A")
               )
        .from(s
            .leftJoin(a,
                      on: s.id == a.studentID)
            .leftJoin(l, on: l.id == a.lectureID)
            .leftJoin(t, on: t.id == l.teatureID)
        )
        .where(s.year >= 2
            && s.year <= 3
            && (t.office.hasPrefix("A")
                || t.office.isNull)
        )
        .orderBy(s.name.asc)
)

/* Native Types & Literals */

checkSQL(
    SQL.select(1, 1.0, "text", SQLHex(0x1024), SQL.null)
)

/* Unary Operators */

checkSQL(s.id == a.studentID)
checkSQL(!(s.id == a.studentID) )
checkSQL(-s.year)
checkSQL(-SQL.select(s.year).from(s).limit(1))
checkSQL(~SQLHex(0x0012))
checkSQL( s.id.is(a.studentID) )
checkSQL( s.id.isNot(a.studentID) )

checkSQL(exists(SQL.select()
    .from(s)
    .where(s.year >= 3)))

checkSQL(s.birth.isNull)

/* Comparisions, Between, In... */

checkSQL( l.id.between(1, and: 100) )
checkSQL( l.id.notBetween(1, and: 100) )
checkSQL( l.category.between("A", and: "F") )
checkSQL( s.name.in("Steve", "Bill", "Mark") )
checkSQL(
    s.id.in(SQL.select(a.studentID)
        .from(a)
        .where(a.lectureID == 1024))
)

/* Arithmetic Operators */

checkSQL(s.year + 0.5)
checkSQL(100 + s.year)
checkSQL(s.id + 100 < a.studentID || s.id != 50)
checkSQL(s.year & SQLHex(0x1012))

/* Logical Operators */

checkSQL(
    s.name == "Yongha"
        && s.id > 100
        && s.year <= 3
        && !s.name.hasSuffix(" Jack")
        && exists(SQL.select()
            .from(a)
            .where(a.studentID == s.id)
        )
        && notExists(
            SQL.select()
                .from(a)
                .where(a.studentID == s.id
                    && a.lectureID == 1900)
        )
        && s.id + 30 < 200
)
checkSQL(
    s.name == "Yongha"
        && (s.id > 100 || s.id < 70)
        && s.year * 2 <= s.id
        && (s.name.hasPrefix("A") || s.name.hasPrefix("B"))
        || s.name.contains("Jones")
)

/* Case */

checkSQL( when(s.id <= 100, then: 100) )
checkSQL(
    when(s.id <= 100
        || s.year == 4, then: s.name)
        .else(s.name.concat(" *")) )
checkSQL(
    when(s.id <= 100, then: 100)
        .when(s.id <= 200, then: 200)
        .when(s.id <= 300, then: 300)
        .else(400)
)

/* Text Concatnation */

checkSQL( "Mrs.".concat(s.name).concat(" ").concat(s.year) )

/* Text Matching */

checkSQL( s.name.like("Y%") )
checkSQL( s.name.like("Y%", escape: "-") )
checkSQL( s.name.likeIgnoreCase("Y%") )
checkSQL( s.name.contains("o") )
checkSQL( s.name.hasPrefix("Indy") )
checkSQL( s.name.hasSuffix("Jones") )

checkSQL( s.name.containsIgnoreCase("o") )
checkSQL( s.name.hasPrefixIgnoreCase("Indy") )
checkSQL( s.name.hasSuffixIgnoreCase("Jones") )

/* Functions */

checkSQL( SQLFunc("func") )
checkSQL( SQLFunc("func", args: 1, "text", s.year) )
checkSQL( SQL.sum(l.hours) )
checkSQL( SQL.count(.all) )

/* Alias */

checkSQL( SQLAlias(SQL.select().from(s.table), alias: "sub") )
checkSQL( SQLAlias(s.name, alias: "name") )
checkSQL( s.as("tbl_alias") )
checkSQL( (s.year * 3).as("col_alias") )

/* Prepared Stateent */

checkSQL( s.year == .prepared )
checkSQL( s.name.like(.prepared) )
checkSQL( s.name.containsIgnoreCase(.prepared) )
checkSQL( s.name.hasPrefixIgnoreCase(.prepared) )
checkSQL( s.name.hasSuffixIgnoreCase(.prepared) )

/* Select */

checkSQL(
    SQL.select()
        .from(s)
)
checkSQL(
    SQL.select(s.name, s.birth)
        .from(s)
)

checkSQL(
    SQL.select(s.name, s.birth, a.lectureID)
        .from(s, a)
        .where(s.id == a.studentID)
        .groupBy(s.year, s.birth)
        .having(SQL.sum(s.year) < 4)
        .orderBy(s.name.asc, s.birth.desc)
        .limit(100, offset: 40)
)

/* Insert */

checkSQL(
    SQL.insert(into: s)
)
checkSQL(
    SQL.insert(into: s)
        .columns(s.id, s.name)
        .values(10, "Yongha")
)
checkSQL(
    SQL.replace(into: s)
        .columns(s.id, s.name)
        .values(10, "Yongha")
)
checkSQL(
    SQL.insert(or: .replace, into: s)
        .columns(s.id, s.name)
        .values(10, "Yongha")
)
checkSQL(
    SQL.insert(or: .replace, into: s)
        .columns(s.id, s.name)
        .values(.prepared)
)
checkSQL(
    SQL.insert(into: s)
        .columns(s.id, s.name)
        .select(SQL.select(100, "inkyfox"))
)
checkSQL(
    SQL.insert(into: s)
        .columns(s.id, s.name)
        .values(10, "Yongha")
        .values(20, "Soyul")
        .values(100, "inkyfox")
)

/* Update */
checkSQL(
    SQL.update(s)
        .set(s.year, 4)
        .where(s.id == 10)
)
checkSQL(
    SQL.update(s)
        .set(s.name, "Yongha")
        .set(s.year, 2)
        .where(s.id == 10)
)
checkSQL(
    SQL.update(s)
        .set([s.name, s.year],
             ["Yongha", 100])
        .where(s.id == 10)
)
checkSQL(
    SQL.update(s)
        .set([s.name, s.year],
             SQL.select(s.name, s.year)
                .from(s)
                .where(s.id == 20))
        .where(s.id == 10)
)

/* delete */

checkSQL( SQL.delete(from: s) )
checkSQL( SQL.delete(from: s).where(s.id == 10) )

