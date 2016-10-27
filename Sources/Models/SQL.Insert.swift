//
//  SQL.Insert.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public class Insert: SQLQueryType {
        
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
        var columns: [Column] = []
        
        var values: [[SQLExprType]] = []
        var select: Select? = nil
        
        init(_ action: Action, into table: SQLSourceTableType) {
            self.action = action
            self.table = table
        }

    }
    
}

extension SQL.Insert {
    
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
    
    public static func insert(into table: SQLSourceTableType) -> Insert {
        return Insert(.insert, into: table)
    }
    
    public static func replace(into table: SQLSourceTableType) -> Insert {
        return Insert(.replace, into: table)
    }
    
    public static func insert(or orAction: Insert.OrAction, into table: SQLSourceTableType) -> Insert {
        return Insert(orAction.action, into: table)
    }
    
}

extension SQL.Insert {
    
    public func columns(_ columns: [SQL.Column]) -> SQL.Insert {
        self.columns += columns
        return self
    }
    
    public func columns(_ columns: SQL.Column...) -> SQL.Insert {
        self.columns += columns
        return self
    }
    
}

extension SQL.Insert {

    public func values(_ values: [SQLExprType]) -> SQL.Insert {
        select = nil
        self.values.append(values)
        return self
    }

    public func values(_ values: SQLExprType...) -> SQL.Insert {
        select = nil
        self.values.append(values)
        return self
    }
    
    public func values(_ values: SQL.Tuple) -> SQL.Insert {
        select = nil
        self.values.append(values.exprs)
        return self
    }
 
    public func values(_ prepared: SQL.PreparedMark) -> SQL.Insert {
        select = nil
        self.values.append(Array<SQL.PreparedMark>(repeating: .prepared, count: columns.count))
        return self
    }
    
    public func select(_ select: SQL.Select) -> SQL.Insert {
        values.removeAll()
        self.select = select
        return self
    }

}
