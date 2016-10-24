//
//  TollFreeSQLValueType.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public protocol TollFreeSQLValueType: SQLValueType, SQLAliasable, SQLConditionType { }

extension TollFreeSQLValueType {
    public func sqlString(by generator: SQLGenerator) -> String {
        return "\(self)"
    }
    
    public func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return "\(self)"
    }
}

extension Int: TollFreeSQLValueType { }

extension Float: TollFreeSQLValueType { }

extension Double: TollFreeSQLValueType { }

extension String: SQLValueType, SQLAliasable {

    public func sqlString(by generator: SQLGenerator) -> String {
        return "\"\(self)\""
    }
    
    public func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return "\"\(self)\""
    }
    
}

extension Character: SQLValueType, SQLAliasable {
    
    public func sqlString(by generator: SQLGenerator) -> String {
        return "'\(self)'"
    }
    
    public func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return "'\(self)'"
    }
    
}
