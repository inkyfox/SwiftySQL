//
//  SQL.Select.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public class Select: SQLQueryType, SQLColumnType, SQLSourceTableType, SQLAliasable {
        
        var columns: [SQLColumnType] = []
        var tables: [SQLSourceTableType] = []
        var condition: SQLConditionType? = nil
        var groups: [SQLColumnType] = []
        var having: SQLConditionType? = nil
        var orders: [SQLOrderType] = []
        var limit: Limit? = nil
        
        internal init() { }
        
    }
    
}

extension SQL.Select {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self)
    }
    
    public func formattedQuery(by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self)
    }
    
    public var description: String { return query(by: SQLGenerator.default) }
    
    public var debugDescription: String { return formattedQuery(by: SQLGenerator.default) }

}

extension SQL.Select {
    
    public func select(_ column: SQLColumnType) -> SQL.Select {
        columns.append(column)
        return self
    }
    
    public func select(_ columns: [SQLColumnType]) -> SQL.Select {
        self.columns += columns
        return self
    }
    
    public func from(_ table: SQLSourceTableType) -> SQL.Select {
        tables.append(table)
        return self
    }
    
    public func from(_ tables: [SQLSourceTableType]) -> SQL.Select {
        self.tables += tables
        return self
    }
    
    public func `where`(_ condition: SQLConditionType) -> SQL.Select {
        self.condition = condition
        return self
    }
    
    public func groupBy(_ group: SQLColumnType) -> SQL.Select {
        groups.append(group)
        return self
    }
    
    public func groupBy(_ groups: [SQLColumnType]) -> SQL.Select {
        self.groups += groups
        return self
    }
    
    public func having(_ having: SQLConditionType) -> SQL.Select {
        self.having = having
        return self
    }
    
    public func orderBy(_ order: SQLOrderType) -> SQL.Select {
        orders.append(order)
        return self
    }
    
    public func orderBy(_ orders: [SQLOrderType]) -> SQL.Select {
        self.orders += orders
        return self
    }
    
    public func limit(_ limit: SQL.Limit) -> SQL.Select {
        self.limit = limit
        return self
    }
    
    public func limit(_ limit: UInt, offset: UInt? = nil) -> SQL.Select {
        self.limit = SQL.Limit(limit: limit, offset: offset)
        return self
    }
    
}

extension SQL {
    
    public static func select() -> SQL.Select {
        return Select()
    }
    
    
    public static func select(_ column: SQLColumnType) -> SQL.Select {
        let builder = Select()
        return builder.select(column)
    }
    
    public static func select(_ columns: [SQLColumnType]) -> SQL.Select {
        let builder = Select()
        return builder.select(columns)
    }
    
    public static func select(from source: SQLSourceTableType) -> SQL.Select {
        let builder = Select()
        return builder.from(source)
    }
    
    public static func select(from sources: [SQLSourceTableType]) -> SQL.Select {
        let builder = Select()
        return builder.from(sources)
    }
}



