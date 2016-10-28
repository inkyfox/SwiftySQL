//
//  SQLInsert.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public class SQLInsert: SQLQueryType {
    
    enum Action {
        case insert, replace
        case insertOrReplace, insertOrRollback, insertOrAbort, insertOrFail, insertOrIgnore
    }
    
    public enum OrAction {
        case replace, rollback, abort, fail, ignore
        
        var action: Action {
            switch self {
            case .replace: return .insertOrReplace
            case .rollback: return .insertOrRollback
            case .abort: return .insertOrAbort
            case .fail: return .insertOrFail
            case .ignore: return .insertOrIgnore
            }
        }
    }
    
    let action: Action
    let table: SQLSourceTableType
    var columns: [SQLColumn] = []
    
    var values: [[SQLExprType]] = []
    var select: SQLSelect? = nil
    
    init(_ action: Action, into table: SQLSourceTableType) {
        self.action = action
        self.table = table
    }
    
}

extension SQLInsert {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self, forRead: false)
    }
    
    public func formattedQuery(withIndent indent: Int = 0, by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self, forRead: false, withIndent: indent)
    }
    
    public var description: String {
        return query(by: SQLGenerator.default)
    }
    
    public var debugDescription: String {
        return formattedQuery(by: SQLGenerator.default)
    }
    
}

extension SQL {
    
    public static func insert(into table: SQLSourceTableType) -> SQLInsert {
        return SQLInsert(.insert, into: table)
    }
    
    public static func replace(into table: SQLSourceTableType) -> SQLInsert {
        return SQLInsert(.replace, into: table)
    }
    
    public static func insert(or orAction: SQLInsert.OrAction, into table: SQLSourceTableType) -> SQLInsert {
        return SQLInsert(orAction.action, into: table)
    }
    
}

extension SQLInsert {
    
    public func columns(_ columns: [SQLColumn]) -> SQLInsert {
        self.columns += columns
        return self
    }
    
    public func columns(_ columns: SQLColumn...) -> SQLInsert {
        self.columns += columns
        return self
    }
    
}

extension SQLInsert {

    public func values(_ values: [SQLExprType]) -> SQLInsert {
        select = nil
        self.values.append(values)
        return self
    }

    public func values(_ values: SQLExprType...) -> SQLInsert {
        select = nil
        self.values.append(values)
        return self
    }
    
    public func values(_ values: SQLTuple) -> SQLInsert {
        select = nil
        self.values.append(values.exprs)
        return self
    }
 
    public func values(_ prepared: SQLPreparedMark) -> SQLInsert {
        select = nil
        self.values.append(Array<SQLPreparedMark>(repeating: .prepared, count: columns.count))
        return self
    }
    
    public func select(_ select: SQLSelect) -> SQLInsert {
        values.removeAll()
        self.select = select
        return self
    }

}
