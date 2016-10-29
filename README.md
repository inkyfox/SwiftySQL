# SwiftySQL
======================================

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Travis CI](https://travis-ci.org/inkyfox/SwiftySQL.svg?branch=master)](https://travis-ci.org/inkyfox/SwiftySQL)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
[![Version](https://img.shields.io/cocoapods/v/SwiftySQL.svg?style=flat)](http://cocoapods.org/pods/SwiftySQL)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Swift Package Manager compatible](https://img.shields.io/badge/Swift%20Package%20Manager-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)

## Write your SQL in Swift

`SwiftySQL` is the easiest way to write SQL in Swift:

- Minimize SQL String literals.
- Use **Swift variables** for table and column names with **auto completion** and **syntax highlighting**.
- Use **Swift operators** and expressions for SQL expressions.

`SwiftSQL` does not provide the ORM-like feature, just builds SQL statement strings.

For example, you can write Swift codes:

``` swift
SQL.select(s.name)
  .from(s)
  .where(s.year >= 3 
         && s.id < 100)
```

to generate SQL string:

``` SQL
SELECT s.name 
FROM   student AS s 
WHERE  s.year >= 3 
       AND s.id < 100
```

More complex SQL:

<table width="100%">
  <tr>
    <th width="50%">Swift</th>
    <th width="50%">SQL</th>
  </tr>
  <tr>
    <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(s.name, 
           s.birth)
  .from(s, a)
  .where(s.id == a.studentID)
  .orderBy(s.name.asc) </pre></td>
    <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT s.name,
       s.birth
FROM   student AS s,
       attending AS a
WHERE  s = a.student_id
ORDER  BY s.name ASC </pre></td>
  </tr>
</table>

Even more complex SQL:

<table width="100%">
  <tr>
    <th width="50%">Swift</th>
    <th width="50%">SQL</th>
  </tr>
  <tr>
    <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(s.name,
           when(l.name.isNotNull,
                then: l.name)
            .else("N/A"),
           when(t.name.isNotNull,
                then: t.name)
            .else("N/A")
           )
  .from(s
    .leftJoin(a,
              on: s.id == a.studentID)
    .leftJoin(l, 
              on: l.id == a.lectureID)
    .leftJoin(t, 
              on: t.id == l.teatureID)
  )
  .where(s.year >= 2 
    && s.year <= 3
    && (t.office.hasPrefix("A")
        || t.office.isNull)
  )
  .orderBy(s.name.asc) </pre></td>
    <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT s.name,
       CASE 
         WHEN l.name NOTNULL THEN l.name 
         ELSE 'N/A' 
       END,
       CASE 
         WHEN t.name NOTNULL THEN t.name 
         ELSE 'N/A' 
       END
FROM   student AS s
       LEFT JOIN attending AS a
              ON s.id = a.student_id
       LEFT JOIN lecture AS l
              ON l.id = a.lecture_id
       LEFT JOIN teature AS t
              ON t.id = l.teature_id
WHERE  s.year >= 2
       AND s.year <= 3
       AND ( t.office LIKE 'A%'
             OR t.office ISNULL )
ORDER  BY s.name ASC </pre></td>
  </tr>
</table>

## Requirements

- iOS 8.0+ | macOS 10.10+ | tvOS 9.0+ | watchOS 2.0+
- Xcode 8

## Installation

### [CocoaPods](https://guides.cocoapods.org/using/using-cocoapods.html)
```
# Podfile
use_frameworks!

target 'YOUR_TARGET_NAME' do
    pod 'SwiftySQL'
end
```

Replace `YOUR_TARGET_NAME` and then, in the `Podfile` directory, type:

```
$ pod install
```

### [Carthage](https://github.com/Carthage/Carthage)

Add this to `Cartfile`

```
github "inkyfox/SwiftySQL"
```

```
$ carthage update
```

### [Swift Package Manager](https://github.com/apple/swift-package-manager)

Create a `Package.swift` file.

```
import PackageDescription

let package = Package(
    name: "TestProject",
    targets: [],
    dependencies: [
        .Package(url: "https://github.com/inkyfox/SwiftySQL.git")
    ]
)
```

```
$ swift build
```

## Usages

All public types of `SwiftySQL` comform `SQLStringConvertible` which privides `var description: String` that returns a raw query string and `var debugDescription: String` of a formatted (with indentation) query string.

### `SELECT` Statement
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select() </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT * </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(1, "text", SQLHex(0x16)) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT 1, 'text', 0x16 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select()
  .from(s) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT *
FROM   student AS s </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(from: s) 
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT *
FROM   student AS s </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select()
  .from(s, a) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT *
FROM   student AS s,
       attending AS a </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(s.name,
           s.birth)
  .from(s) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT s.name,
       s.birth
FROM   student AS s </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(s.name,
           s.birth,
           a.lectureID)
  .from(s, a)
  .where(s.id == a.studentID)
  .groupBy(s.year, s.birth)
  .having(SQL.sum(s.year) < 4)
  .orderBy(s.name.asc, s.birth.desc)
  .limit(100, offset: 40) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT s.name,
       s.birth,
       a.lecture_id
FROM   student AS s,
       attending AS a
WHERE  s.id = a.student_id
GROUP  BY s.year,
          s.birth
HAVING SUM(s.year) < 4
ORDER  BY s.name ASC,
          s.birth DESC
LIMIT  100, 40 </pre></td>
</tr>
</table>

### `INSERT` Statement
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.insert(into: s) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
INSERT INTO student
DEFAULT VALUES </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.insert(into: s)
  .columns(s.id, s.name)
  .values(10, "Yongha")
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
INSERT INTO student
            ( id, name )
VALUES      ( 10,
              'Yongha' ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.replace(into: s)
  .columns(s.id, s.name)
  .values(10, "Yongha")
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
REPLACE INTO student
             ( id, name )
VALUES       ( 10,
               'Yongha' ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.insert(or: .replace, into: s)
  .columns(s.id, s.name)
  .values(10, "Yongha")
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
INSERT OR REPLACE INTO student
                  ( id, name )
VALUES            ( 10,
                    'Yongha' ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.insert(or: .replace, into: s)
  .columns(s.id, s.name)
  .values(.prepared)
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
INSERT INTO student
            ( id, name )
VALUES      ( ?, 
              ? ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.insert(into: s)
  .columns(s.id, s.name)
  .select(SQL.select(100, "inkyfox"))
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
INSERT INTO student
            ( id, name )
SELECT 100,
       'inkyfox' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
  
SQL.insert(into: s)
  .columns(s.id, s.name)
  .values(10, "Yongha")
  .values(20, "Soyul")
  .values(100, "inkyfox")
  
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
INSERT INTO student
            ( id, name )
VALUES      ( 10,
              'Yongha' ),
            ( 20,
              'Soyul' ),
            ( 100,
              'inkyfox' ) </pre></td>
</tr>
</table>

### `UPDATE` Statement
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.update(s)
  .set(s.year, 4) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPDATE student
SET    year = 4 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.update(s)
  .set(s.year, 4)
  .where(s.id == 10) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPDATE student
SET    year = 4
WHERE  id = 10 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.update(s)
  .set(s.name, "Yongha")
  .set(s.year, 2)
  .where(s.id == 10) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPDATE student
SET    name = 'Yongha',
       year = 2
WHERE  id = 10 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.update(s)
  .set([s.name, s.year],
       ["Yongha", 100])
  .where(s.id == 10)
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPDATE student
SET    ( name, year ) =
         ( 'Yongha',
           100 )
WHERE  id = 10 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.update(s)
  .set([s.name, s.year],
       SQL.select(s.name, s.year)
          .from(s)
          .where(s.id == 20))
  .where(s.id == 10)
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPDATE student
SET    ( name, year ) =
         ( SELECT s.name,
                  s.year
           FROM   student AS s
           WHERE  s.id = 20 )
WHERE  id = 10 </pre></td>
</tr>
</table>

### `DELETE` Statement
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.delete(from: s) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
DELETE FROM student </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.delete(from: s)
  .where(s.id == 10) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
DELETE FROM student
WHERE  id = 10 </pre></td>
</tr>
</table>

### Native Types & Literals

<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.select(1,
           1.0, 
           "text", 
           SQLHex(0x1024),
           SQL.null) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SELECT 1,
       1.0,
       'text',
       0x1024,
       NULL </pre></td>
</tr>
</table>

### Unary Operators
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.id == a.studentID </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.id = a.student_id </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
!(s.id == a.studentID) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
NOT (s.id = a.student_id) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
!s.name.hasPrefix("Yoo") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
NOT (s.name LIKE 'Yoo%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
-s.year </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
-s.year </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
-SQL.select(s.year)
  .from(s)
  .limit(1) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
-( SELECT s.year
   FROM   student AS s
   LIMIT  1 ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
~SQLHex(0x12) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
~0x12 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.birth.isNull </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.birth ISNULL </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.birth.isNotNull </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.birth ISNotNULL </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.id.is(a.studentID) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.id IS a.student_id </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.id.isNot(a.studentID) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.id IS NOT a.student_id </pre></td>
</tr>
</table>

### Arithmetic Operators
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year + 0.5 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year + 0.5 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
100 + s.grade </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
100 + s.year </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year - 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year - 2 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year * 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year * 2 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year / 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year / 2 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year % 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year % 2 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year & SQLHex(0x1012) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year & 0x1012 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year | SQLHex(0x1012) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year | 0x1012 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year << 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year << 2 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year >> 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year >> 2 </pre></td>
</tr>
</table>
  
### Comparision Operators
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.id + 100 < a.studentID 
|| s.id != 50 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.id + 100 < a.student_id
OR s.id <> 50 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year <= 2 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year <= 2 </pre></td>
</tr>
</table>

### `EXISTS`, `BETWEEN` and `IN` 
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
exists(SQL.select()
  .from(s)
  .where(s.year >= 3) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
EXISTS ( SELECT * 
         FROM student AS s
         WHERE s.year >= 3 ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
notExists(SQL.select()
  .from(s)
  .where(s.year >= 3) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
NOT EXISTS ( SELECT * 
             FROM student AS s
             WHERE s.year >= 3 ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
l.id.between(1, and: 100) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
l.id BETWEEN 1 AND 100 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
l.id.notBetween(1, and: 100) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
l.id NOT BETWEEN 1 AND 100 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
l.category.between("A", and: "F") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
l.category BETWEEN 'A' AND 'F' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.in("Steve",
          "Bill",
          "Mark") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name IN ( 'Steve',
            'Bill',
            'Mark' ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.notIn("Steve",
             "Bill",
             "Mark") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name NOT IN ( 'Steve',
                'Bill',
                'Mark' ) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.id.in(SQL.select(a.studentID)
  .from(a)
  .where(a.lectureID == 1024) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.id IN ( SELECT a.student_id
          FROM   attending AS a
          WHERE  a.lecture_id = 1024 ) </pre></td>
</tr>
</table>

### Logical Operators
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name == "Yongha"
  && s.id > 100
  && s.year <= 3
  && !s.name.hasSuffix(" Jack")
  && exists(SQL.select()
              .from(a)
              .where(a.studentID == s.id))
  && notExists(SQL.select()
                 .from(a)
                 .where(a.studentID == s.id
                        && a.lectureID == 9))
  && s.id + 30 < 200 </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name = 'Yongha'
AND s.id > 100
AND s.year <= 3
AND NOT ( s.name LIKE '% Jack' )
AND EXISTS ( SELECT *
             FROM   attending AS a
             WHERE  a.student_id = s.id )
AND NOT EXISTS ( SELECT *
                 FROM   attending AS a
                 WHERE  a.student_id = s.id
                        AND a.lecture_id = 9 )
AND s.id + 30 < 200 </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name == "Yongha"
  && (s.id > 100 
      || s.id < 70)
  && s.year * 2 <= s.id
  && (s.name.hasPrefix("A") 
      || s.name.hasPrefix("B"))
  || s.name.contains("Jones") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name = 'Yongha'
AND ( s.id > 100
      OR s.id < 70 )
AND s.year * 2 <= s.id
AND ( s.name LIKE 'A%'
      OR s.name LIKE 'B%' )
OR s.name LIKE '%Jones%' </pre></td>
</tr>
</table>

### `CASE`
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
when(s.id <= 100, then: 100) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
CASE 
  WHEN s.id <= 100 THEN 100 
END </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
  
when(s.id <= 100, then: 100)
  .else(200)
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
CASE 
  WHEN s.id <= 100 THEN 100
  ELSE 200
END </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
when(s.id <= 100 
  || s.year == 4, then: s.name)
  .else(s.name.concat(" *")) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
CASE 
  WHEN s.id <= 100
       OR s.year = 4 THEN s.name 
  ELSE s.name || ' *' 
END </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
  
when(s.id <= 100, then: 100)
  .when(s.id <= 200, then: 200)
  .when(s.id <= 300, then: 300)
  .else(400)
    </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
CASE 
  WHEN s.id <= 100 THEN 100 
  WHEN s.id <= 200 THEN 200 
  WHEN s.id <= 300 THEN 300 
  ELSE 400 
END </pre></td>
</tr>
</table>

### Text Concatnation
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
"Mrs.".concat(s.name).concat(s.year) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
'Mrs.' || s.name || s.year </pre></td>
</tr>
</table>

### Text Matching
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.like("Y%") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name LIKE 'Y%' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.like("Y%", escape: "-") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name LIKE 'Y%' ESCAPE '-' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.notLike("Y%") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name NOT LIKE 'Y%' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.notLike("Y%", escape: "-") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name NOT LIKE 'Y%' ESCAPE '-' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.contains("o") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name LIKE '%o%' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.hasPrefix("Indy") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name LIKE 'Indy%' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.hasSuffix("Jones") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name LIKE '%Jones' </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.likeIgnoreCase("Y%") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER('Y%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.notLikeIgnoreCase("Y%") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) NOT LIKE UPPER('Y%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.containsIgnoreCase("o") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER('%o%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.hasPrefixIgnoreCase("Indy") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER('Indy%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.hasSuffixIgnoreCase("Jones") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER('%Jones') </pre></td>
</tr>
</table>
  
### Functions
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQLFunc("func") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
func() </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQLFunc("func", 
        args: 1, "text", s.year)) 
        </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
func(1,
     'text',
     s.year) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.count(.all) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
COUNT(*) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.sum(l.hours) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
SUM(l.hours) </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQL.length(s.name) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
LENGTH(s.name) </pre></td>
</tr>
</table>

Common function templete methods are provided: `SQL.count()`, `SQL.avg()`, `SQL.max()`, `SQL.min()`, `SQL.sum()`, `SQL.total()`, `SQL.abs()`, `SQL.length()`, `SQL.upper()`, `SQL.lower()`

### Alias
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQLAlias(SQL.select().from(s.table),
         alias: "sub") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
( SELECT *
  FROM   student ) AS sub </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQLAlias(s.name, alias: "name") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name AS name </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.as("tbl_alias") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
student AS tbl_alias </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
(s.year * 3).as("col_alias") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
( s.year * 3 ) AS col_alias </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
SQLColumn(table: "tbl_alias", column: "name") </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
tbl_alias.name </pre></td>
</tr>
</table>

### Prepared Statement
  
<table width="100%">
<tr>
  <th width="50%">Swift</th>
  <th width="50%">SQL</th>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year == .prepared </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year = ? </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.year + .prepared </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.year + ? </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.like(.prepared) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
s.name LIKE ? </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.containsIgnoreCase(.prepared) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER('%' || ? || '%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.hasPrefixIgnoreCase(.prepared) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER(? || '%') </pre></td>
</tr>
<tr>
  <td width="50%" style="padding:0;"><pre lang="swift" style="border: none;">
s.name.hasSuffixIgnoreCase(.prepared) </pre></td>
  <td width="50%" style="padding:0;"><pre lang="sql" style="border: none;">
UPPER(s.name) LIKE UPPER('%' || ?) </pre></td>
</tr>
</table>
  