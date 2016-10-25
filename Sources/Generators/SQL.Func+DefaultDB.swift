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
            let query = element.args
                .map { $0.sqlString(by: generator) }
                .joined(separator: ", ")
            return "\(element.name)(\(query))"
        }
        
        override func generateFormatted(_ element: SQL.Func,
                                        withIndent indent: Int) -> String {
            let argIndent = element.name.characters.count + 1
            let query = element.args
                .map { $0.formattedSQLString(withIndent: argIndent, by: generator) }
                .joined(separator: ",\n\(space(argIndent))")
            return "\(element.name)(\(query))"
        }
    }

}
