//
//  SQL.Alias+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Alias {
    
    class Generator: SQLElementGenerator<SQL.Alias> {
        
        override func generate(_ element: SQL.Alias) -> String {
            return "\(element.sql.sqlString(by: generator).parenthesesIfNeeded) AS \(element.alias)"
        }
        
        override func generateFormatted(_ element: SQL.Alias,
                                        withIndent indent: Int) -> String {
            if element.sql.sqlString(by: generator).needParentheses {
                return "( \(element.sql.formattedSQLString(withIndent: indent + 2, by: generator)) ) AS \(element.alias)"
            } else {
                return "\(element.sql.formattedSQLString(withIndent: indent, by: generator)) AS \(element.alias)"
            }
        }
        
    }
    
}
