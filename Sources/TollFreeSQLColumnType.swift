//
//  TollFreeSQLColumnType.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public protocol TollFreeSQLColumnType: SQLColumnType, SQLAliasable, SQLConditionType { }

extension TollFreeSQLColumnType {
    public func sqlString(by generator: SQLGenerator) -> String {
        return "\(self)"
    }
    
    public func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return "\(self)"
    }
}

extension Int: TollFreeSQLColumnType { }

extension Float: TollFreeSQLColumnType { }

extension Double: TollFreeSQLColumnType { }

extension String: SQLColumnType, SQLAliasable {

    public func sqlString(by generator: SQLGenerator) -> String {
        return "\"\(self)\""
    }
    
    public func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return "\"\(self)\""
    }
    
}

extension Character: SQLColumnType, SQLAliasable {
    
    public func sqlString(by generator: SQLGenerator) -> String {
        return "'\(self)'"
    }
    
    public func formattedSQLString(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return "'\(self)'"
    }
    
}
