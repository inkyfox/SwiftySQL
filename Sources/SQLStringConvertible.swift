//
//  SQLStringConvertible.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public protocol SQLStringConvertible: CustomStringConvertible, CustomDebugStringConvertible {
    
    func sqlString(by generator: SQLGenerator) -> String
    
    func formattedSQLString(withIndent indent: Int,
                            by generator: SQLGenerator) -> String

}

extension SQLStringConvertible {
    
    public func sqlString(by generator: SQLGenerator) -> String {
        return generator.generate(self)
    }
    
    public func formattedSQLString(withIndent indent: Int,
                                   by generator: SQLGenerator) -> String {
        return generator.generateFormatted(self, withIndent: indent)
    }
    
    public var description: String {
        return sqlString(by: SQLGenerator.default)
    }

    public var debugDescription: String {
        return formattedSQLString(withIndent: 0, by: SQLGenerator.default)
    }
}

extension SQLStringConvertible {
    
    var needBoxed: Bool {
        return self is SQLOperaorExprType
    }
    
    func sqlStringBoxedIfNeeded(by generator: SQLGenerator) -> String {
        let str = sqlString(by: generator)
        return needBoxed ? str.boxed : str
    }

    func formattedSQLStringBoxedIfNeeded(withIndent indent: Int,
                                         by generator: SQLGenerator) -> String {
        return needBoxed ?
            formattedSQLString(withIndent: indent + 2, by: generator).boxedWithSpace :
            formattedSQLString(withIndent: indent, by: generator)
    }

    func formattedSQLStringBoxed(withIndent indent: Int,
                                   by generator: SQLGenerator) -> String {
        return formattedSQLString(withIndent: indent + 2, by: generator).boxedWithSpace
    }
    

}

//extension Sequence where Iterator.Element : SQLStringConvertible {
//    
//    func sqlString(by generator: SQLGenerator) -> String {
//        return self
//            .map { $0.sqlString(by: generator) }
//            .joined(separator: ", ")
//    }
//
//    func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
//        return self
//            .map { $0.formattedSQLString(withIndent: indent, by: generator) }
//            .joined(separator: ",\n\(space(indent))")
//    }
//    
//}
//
