# SwiftySQL
======================================

![Swift](https://img.shields.io/badge/Swift-3.0-orange.svg)
[![Travis CI](https://travis-ci.org/inkyfox/SwiftySQL.svg?branch=master)](https://travis-ci.org/inkyfox/SwiftySQL)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS-333333.svg)
[![Version](https://img.shields.io/cocoapods/v/SwiftySQL.svg?style=flat)](http://cocoapods.org/pods/SwiftySQL)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

## Write your SQL in Swift

`SwiftySQL` is the easiest way to write SQL in Swift:

- Minimize SQL String literals.
- Use Swift variables for table and column names.
- Use Swift operators and expressions for SQL expressions.

For example, you can write Swift codes:

``` swift
SQL.select(s.name).from(s).where(s.year >= 3 && s.id < 100)
```

to generate SQL string:

``` SQL
SELECT s.name FROM student AS s WHERE s.year >= 3 AND s.id < 100
```

More complex SQL:

<table width="100%">
  <tr>
    <th width="50%">Swift</th>
    <th width="50%">SQL</th>
  </tr>
  <tr>
    <td width="50%"><pre lang="swift" style="border: none;">
SQL.select(s.name, 
           s.birth)
  .from(s, a)
  .where(s.id == a.studentID)
  .orderBy(s.name.asc)
    </pre></td>
    <td width="50%"><pre lang="sql" style="border: none;">
SELECT s.name,
       s.birth
FROM   student AS s,
       attending AS a
WHERE  s = a.student_id
ORDER  BY s.name ASC
    </pre></td>
  </tr>
</table>

Even more complex SQL:

<table width="100%">
  <tr>
    <th width="50%">Swift</th>
    <th width="50%">SQL</th>
  </tr>
  <tr>
    <td width="50%"><pre lang="swift" style="border: none;">
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
  .orderBy(s.name.asc)
    </pre></td>
    <td width="50%"><pre lang="sql" style="border: none;">
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
ORDER  BY s.name ASC
    </pre></td>
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
