//
//  SQL.Join+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Join {

    class Generator: SQLElementGenerator<SQL.Join> {
        
        private func typeString(_ type: SQL.Join.JoinType) -> String {
            switch type {
            case .inner: return "JOIN"
            case .leftOuter: return "LEFT JOIN"
            case .cross: return "CROSS JOIN"
            case .natural: return "NATURAL JOIN"
            case .naturalLeftOuter: return "NATURAL LEFT JOIN"
            }
        }
        
        override func generate(_ element: SQL.Join) -> String {
            let join = "\(element.left.sqlString(by: generator)) \(typeString(element.type)) \(element.right.sqlString(by: generator))"
            
            if let on = element.on {
                return "\(join) ON \(on.sqlString(by: generator))"
            } else {
                return join
            }
        }
        
        override func generateFormatted(_ element: SQL.Join,
                                        withIndent indent: Int) -> String {
            let line0 = "\(element.left.formattedSQLString(withIndent: indent, by: generator))\n"
            var line1 = "\(space(indent))\(typeString(element.type)) "
            let line2Indent = line1.characters.count - 3
            line1 += "\(element.right.formattedSQLString(withIndent: indent + line1.characters.count, by: generator))"
            if let on = element.on {
                let line2 = "\n\(space(line2Indent))ON \(on.formattedSQLString(withIndent: indent + 3, by: generator))"
                return line0 + line1 + line2
            } else {
                return line0 + line1
            }
        }
    }

}

