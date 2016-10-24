//
//  SQL.Update.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public class Update: SQLQueryType {
        
        public enum OrAction {
            case only, replace, rollback, abort, fail, ignore
        }
        
        let orAction: OrAction
        let table: Table
        var sets: [([Column], [SQLValueType])] = []
        var condition: SQLConditionType?
        
        init(_ orAction: OrAction, _ table: Table) {
            self.orAction = orAction
            self.table = table
        }
        
    }
    
}

extension SQL.Update {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self)
    }
    
    public func formattedQuery(withIndent indent: Int = 0, by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self, withIndent: indent)
    }
    
    public var description: String {
        return query(by: SQLGenerator.default)
    }
    
    public var debugDescription: String {
        return formattedQuery(by: SQLGenerator.default)
    }
    
}

extension SQL {
    
    public static func update(_ table: Table) -> Update {
        return Update(.only, table)
    }

    public static func update(or orAction: Update.OrAction, _ table: Table) -> Update {
        return Update(orAction, table)
    }

}

extension SQL.Update {
    
    public func set(_ column: SQL.Column, _ value: SQLValueType) -> SQL.Update {
        self.sets.append(([column], [value]))
        return self
    }
    
    public func set(_ columns: [SQL.Column], _ value: SQL.Select) -> SQL.Update {
        self.sets.append((columns, [value]))
        return self
    }
    
    public func set(_ columns: [SQL.Column], _ values: [SQLValueType]) -> SQL.Update {
        self.sets.append((columns, values))
        return self
    }
    
    public func `where`(_ condition: SQLConditionType) -> SQL.Update {
        self.condition = condition
        return self
    }
    
}

