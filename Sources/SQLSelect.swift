//
//  SQLSelect.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public class SQLSelect: SQLQueryType, SQLValueType, SQLConditionType, SQLSourceTableType,  SQLAliasable {
    
    var columns: [SQLValueType] = []
    var tables: [SQLSourceTableType] = []
    var condition: SQLConditionType? = nil
    var groups: [SQLValueType] = []
    var having: SQLConditionType? = nil
    var orders: [SQLOrderType] = []
    var limit: SQLLimit? = nil
    
    internal init() { }
    
}

extension SQLSelect {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self, forRead: true)
    }
    
    public func formattedQuery(withIndent indent: Int = 0, by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self, forRead: true, withIndent: indent)
    }
    
    public var description: String {
        return query(by: SQLGenerator.default)
    }
    
    public var debugDescription: String {
        return formattedQuery(by: SQLGenerator.default)
    }

}

extension SQLSelect {
    
    public func select(_ column: SQLValueType) -> SQLSelect {
        columns.append(column)
        return self
    }
    
    public func select(_ columns: [SQLValueType]) -> SQLSelect {
        self.columns += columns
        return self
    }
    
    public func select(_ columns: SQLValueType...) -> SQLSelect {
        self.columns += columns
        return self
    }

    
    public func from(_ table: SQLSourceTableType) -> SQLSelect {
        tables.append(table)
        return self
    }
    
    public func from(_ tables: [SQLSourceTableType]) -> SQLSelect {
        self.tables += tables
        return self
    }
    
    public func from(_ tables: SQLSourceTableType...) -> SQLSelect {
        self.tables += tables
        return self
    }

    public func `where`(_ condition: SQLConditionType) -> SQLSelect {
        self.condition = condition
        return self
    }
    
    public func groupBy(_ group: SQLValueType) -> SQLSelect {
        groups.append(group)
        return self
    }
    
    public func groupBy(_ groups: [SQLValueType]) -> SQLSelect {
        self.groups += groups
        return self
    }
    
    public func groupBy(_ groups: SQLValueType...) -> SQLSelect {
        self.groups += groups
        return self
    }
    
    public func having(_ having: SQLConditionType) -> SQLSelect {
        self.having = having
        return self
    }
    
    public func orderBy(_ order: SQLOrderType) -> SQLSelect {
        orders.append(order)
        return self
    }
    
    public func orderBy(_ order: SQLValueType, _ sort: SQLOrder.Sort) -> SQLSelect {
        orders.append(SQLOrder(column: order, sort: sort))
        return self
    }
    
    public func orderBy(_ orders: [SQLOrderType]) -> SQLSelect {
        self.orders += orders
        return self
    }

    public func orderBy(_ orders: SQLOrderType...) -> SQLSelect {
        self.orders += orders
        return self
    }

    public func limit(_ limit: UInt, offset: UInt? = nil) -> SQLSelect {
        self.limit = SQLLimit(limit: limit, offset: offset)
        return self
    }
    
}

extension SQL {
    
    public static func select() -> SQLSelect {
        return SQLSelect()
    }
    
    public static func select(_ all: SQLAsteriskMark) -> SQLSelect {
        return SQLSelect()
    }
    
    public static func select(_ column: SQLValueType) -> SQLSelect {
        let builder = SQLSelect()
        return builder.select(column)
    }
    
    public static func select(_ columns: [SQLValueType]) -> SQLSelect {
        let builder = SQLSelect()
        return builder.select(columns)
    }
    
    public static func select(_ columns: SQLValueType...) -> SQLSelect {
        let builder = SQLSelect()
        return builder.select(columns)
    }

    public static func select(from source: SQLSourceTableType) -> SQLSelect {
        let builder = SQLSelect()
        return builder.from(source)
    }
    
    public static func select(from sources: [SQLSourceTableType]) -> SQLSelect {
        let builder = SQLSelect()
        return builder.from(sources)
    }
    
    public static func select(from sources: SQLSourceTableType...) -> SQLSelect {
        let builder = SQLSelect()
        return builder.from(sources)
    }

}



