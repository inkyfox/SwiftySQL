# SwiftySQL
======================================

## Write your SQL in Swift

`SwiftySQL` is the easiest way to write SQL in Swift:

- Minimize SQL String literals.
- Use Swift variables for table and column names.
- Use Swift operators and expressions for SQL expressions.

For example, you can write Swift codes:

``` swift
SQL.select(student.name).from(student).where(student.year >= 3 && student.id < 100)
```

to generate SQL string:

``` SQL
SELECT s.name FROM student AS s WHERE s.year >= 3 AND s.id < 100
```

More complex SQL:

<table>
  <tr>
    <th width="50%">Swift</th>
    <th width="50%">SQL</th>
  </tr>
  <tr>
    <td width="50%"><pre lang="swift" style="border: none;">
SQL.select(student.name, 
           student.birth)
  .from(student,
        attending)
  .where(student.id == attending.studentID)
  .orderBy(student.name.asc)
    </pre></td>
    <td width="50%"><pre lang="sql" style="border: none;">
SELECT s.name,
       s.birth
FROM   student AS s,
       user.attending AS a
WHERE  s = a.student_id
ORDER  BY s.name ASC
    </pre></td>
  </tr>
</table>

Even more complex SQL:

<table>
  <tr>
    <th width="50%">Swift</th>
    <th width="50%">SQL</th>
  </tr>
  <tr>
    <td width="50%"><pre lang="swift" style="border: none;">
SQL.select(student.name,
           when(lecture.name.isNotNull,
                then: lecture.name)
            .else("N/A"),
           when(teature.name.isNotNull,
                then: teature.name)
            .else("N/A")
           )
  .from(student
    .leftJoin(attending,
              on: student.id == attending.studentID)
    .leftJoin(lecture, 
              on: lecture.id == attending.lectureID)
    .leftJoin(teature, 
              on: teature.id == lecture.teatureID)
  )
  .where(student.year >= 2 
    && student.year <= 3
    && (teature.office.hasPrefix("A")
        || teature.office.isNull)
  )
  .orderBy(student.name.asc)
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

