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
        
        override func generate(_ element: SQL.Join, forRead: Bool) -> String {
            let join = element.left.sqlString(forRead: forRead, by: generator)
                + " " + typeString(element.type)
                + " " + element.right.sqlString(forRead: forRead, by: generator)
            
            if let on = element.on {
                return "\(join) ON \(on.sqlString(forRead: forRead, by: generator))"
            } else {
                return join
            }
        }
        
        override func generateFormatted(_ element: SQL.Join,
                                        forRead: Bool,
                                        withIndent indent: Int) -> String {
            let line0 = element.left.formattedSQLString(forRead: forRead,
                                                        withIndent: indent,
                                                        by: generator)
                + "\n"
            var line1 = space(indent) + typeString(element.type) + " "
            let line2Indent = line1.characters.count - 3
            line1 += element.right.formattedSQLString(forRead: forRead,
                                                      withIndent: line1.characters.count,
                                                      by: generator)
            if let on = element.on {
                let line2 = "\n" + space(line2Indent)
                    + "ON " + on.formattedSQLString(forRead: forRead,
                                                    withIndent: indent + 3,
                                                    by: generator)
                return line0 + line1 + line2
            } else {
                return line0 + line1
            }
        }
    }

}

