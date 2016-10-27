//
//  SQLStringConvertible.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public protocol SQLStringConvertible: CustomStringConvertible, CustomDebugStringConvertible {
    
    func sqlString(forRead: Bool, by generator: SQLGenerator) -> String
    
    func formattedSQLString(forRead: Bool, withIndent indent: Int, by generator: SQLGenerator) -> String

}

extension SQLStringConvertible {
    
    public func sqlString(forRead: Bool, by generator: SQLGenerator) -> String {
        return generator.generate(self, forRead: forRead)
    }
    
    public func formattedSQLString(forRead: Bool,
                                   withIndent indent: Int,
                                   by generator: SQLGenerator) -> String {
        return generator.generateFormatted(self, forRead: forRead, withIndent: indent)
    }
    
    public var description: String {
        return sqlString(forRead: true, by: SQLGenerator.default)
    }

    public var debugDescription: String {
        return formattedSQLString(forRead: true, withIndent: 0, by: SQLGenerator.default)
    }
}

extension SQLStringConvertible {
    
    var needBoxed: Bool {
        return self is SQLOperaorExprType
    }
    
    func sqlStringBoxedIfNeeded(forRead: Bool, by generator: SQLGenerator) -> String {
        let str = sqlString(forRead: forRead, by: generator)
        return needBoxed ? str.boxed : str
    }

    func formattedSQLStringBoxedIfNeeded(forRead: Bool,
                                         withIndent indent: Int,
                                         by generator: SQLGenerator) -> String {
        return needBoxed ?
            formattedSQLString(forRead: forRead, withIndent: indent + 2, by: generator).boxedWithSpace :
            formattedSQLString(forRead: forRead, withIndent: indent, by: generator)
    }

    func formattedSQLStringBoxed(forRead: Bool,
                                 withIndent indent: Int,
                                 by generator: SQLGenerator) -> String {
        return formattedSQLString(forRead: forRead, withIndent: indent + 2, by: generator).boxedWithSpace
    }

}
