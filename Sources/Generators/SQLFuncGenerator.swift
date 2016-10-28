//
//  SQLFuncGenerator.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLFuncGenerator: SQLElementGenerator<SQLFunc> {
    
    override func generate(_ element: SQLFunc, forRead: Bool) -> String {
        let query = element.args
            .map { $0.sqlString(forRead: forRead, by: generator) }
            .joined(separator: ", ")
        return "\(element.name)(\(query))"
    }
    
    override func generateFormatted(_ element: SQLFunc,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        let argIndent = element.name.characters.count + 1
        let query = element.args
            .map { $0.formattedSQLString(forRead: forRead, withIndent: argIndent, by: generator) }
            .joined(separator: ",\n\(space(argIndent))")
        return "\(element.name)(\(query))"
    }

}
