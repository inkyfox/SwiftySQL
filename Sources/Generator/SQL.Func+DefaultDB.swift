//
//  SQL.Func+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Func {
    
    class Generator: SQLElementGenerator<SQL.Func> {
        
        override func generate(_ element: SQL.Func) -> String {
            if let arguments = element.args {
                let query = arguments
                    .map { $0.sqlString(by: generator) }
                    .joined(separator: ", ")
                return "\(element.name)(\(query))"
            } else {
                return "\(element.name)(*)"
            }
        }
        
        override func generateFormatted(_ element: SQL.Func,
                                        withIndent indent: Int) -> String {
            if let arguments = element.args {
                let query = arguments
                    .map { $0.formattedSQLString(withIndent: 0, by: generator) }
                    .joined(separator: ",\n\(space(indent))")
                return "\(element.name)(\(query))"
            } else {
                return "\(element.name)(*)"
            }
        }
    }

}
