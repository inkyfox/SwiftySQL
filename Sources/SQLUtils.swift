//
//  SQLUtils.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation


internal let whiteSpaces = CharacterSet.whitespacesAndNewlines

extension String {

    var boxed: String {
        return "(\(self))"
    }
    var boxedWithSpace: String {
        return "( \(self) )"
    }

}

private var indentSpaces: [Int : String] = [:]

internal func space(_ indent: Int) -> String {
    if let space = indentSpaces[indent] { return space }
    
    let space = String(repeating: " ", count: indent)
    indentSpaces[indent] = space
    return space
}


internal func sqlJoin(_ sqls: [SQLStringConvertible], by generator: SQLGenerator) -> String {
    return sqls
        .map { $0.sqlString(by: generator) }
        .joined(separator: ", ")
}

internal func formattedSQLJoin(_ sqls: [SQLStringConvertible],
                            withIndent indent: Int, by generator: SQLGenerator) -> String {
    return sqls
        .map { $0.formattedSQLString(withIndent: indent, by: generator) }
        .joined(separator: ",\n" + space(indent))
}

internal func formattedSQLJoinBoxed(_ sqls: [SQLStringConvertible],
                               withIndent indent: Int, by generator: SQLGenerator) -> String {
    return sqls
        .map { $0.formattedSQLString(withIndent: indent + 2, by: generator) }
        .joined(separator: ",\n" + space(indent + 2))
        .boxedWithSpace
}

