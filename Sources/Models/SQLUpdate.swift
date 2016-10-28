//
//  SQLUpdate.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public class SQLUpdate: SQLQueryType {
    
    public enum OrAction {
        case replace, rollback, abort, fail, ignore
    }
    
    let orAction: OrAction?
    let table: SQLSourceTableType
    var sets: [([SQLColumn], [SQLValueType])] = []
    var condition: SQLConditionType?
    
    init(_ orAction: OrAction?, _ table: SQLSourceTableType) {
        self.orAction = orAction
        self.table = table
    }
    
}

extension SQLUpdate {
    
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
    
    public static func update(_ table: SQLSourceTableType) -> SQLUpdate {
        return SQLUpdate(nil, table)
    }
    
    public static func update(or orAction: SQLUpdate.OrAction,
                              _ table: SQLSourceTableType) -> SQLUpdate {
        return SQLUpdate(orAction, table)
    }
    
}

extension SQLUpdate {
    
    public func set(_ column: SQLColumn, _ value: SQLValueType) -> SQLUpdate {
        self.sets.append(([column], [value]))
        return self
    }
    
    public func set(_ column: SQLColumn, _ value: SQLSelect) -> SQLUpdate {
        self.sets.append(([column], [value]))
        return self
    }
    
    
    public func set(_ columns: [SQLColumn], _ value: SQLSelect) -> SQLUpdate {
        self.sets.append((columns, [value]))
        return self
    }
    
    public func set(_ columns: [SQLColumn], _ values: [SQLValueType]) -> SQLUpdate {
        self.sets.append((columns, values))
        return self
    }
    
    public func `where`(_ condition: SQLConditionType) -> SQLUpdate {
        self.condition = condition
        return self
    }
    
}

