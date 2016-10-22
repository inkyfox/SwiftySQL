//
//  SQL.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQL {
    
    open class Alias: SQLColumnType, SQLSourceTableType {
        let sql: SQLAliasable
        let alias: String
        
        public init(_ sql: SQLAliasable, alias: String) {
            self.sql = sql
            self.alias = alias
        }

    }
    
    public struct Column: SQLColumnType, SQLOrderType, SQLAliasable {
        let tableName: String?
        let columnName: String
        
        public init(table: String, column: String) {
            tableName = table
            columnName = column
        }
        
        public init(_ column: String) {
            tableName = nil
            columnName = column
        }

    }
    
    public struct BinaryExpr: SQLColumnType, SQLOrderType, SQLConditionType, SQLAliasable {
        let lhs: SQLExprType
        let op: String
        let rhs: SQLExprType
        
        public init(_ lhs: SQLExprType, _ op: String, _ rhs: SQLExprType) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }
    }
    
    public struct Case: SQLColumnType, SQLOrderType, SQLAliasable {
        struct When  {
            let when: SQLExprType
            let then: SQLExprType
            init(_ when: SQLExprType, then: SQLExprType) {
                self.when = when
                self.then = then
            }
        }
        
        let whenThens: [When]
        let defaultValue: SQLExprType?
        
        public init(when: SQLExprType, then: SQLExprType, else defaultValue: SQLExprType? = nil) {
            self.whenThens = [When(when, then: then)]
            self.defaultValue = defaultValue
        }
        
        public init(_ whenthens: [(when: SQLExprType, then: SQLExprType)], else defaultValue: SQLExprType? = nil) {
            self.whenThens = whenthens.map { When($0.0, then: $0.1) }
            self.defaultValue = defaultValue
        }
    }
    
    public struct Func: SQLColumnType, SQLOrderType, SQLAliasable {
        let name: String
        let args: [SQLExprType]?
        
        public init(_ name: String, args: [SQLExprType]? = []) {
            self.name = name
            self.args = args
        }
    }
    
    public struct Order: SQLOrderType {
        enum Sort {
            case asc, desc
        }
        
        let column: SQLColumnType
        let sort: Sort
    }
    
    public struct Limit: SQLStringConvertible {
        let limit: UInt
        let offset: UInt?
    }
    
    public struct Table: SQLSourceTableType, SQLAliasable {
        public let table: String
        
        public init(_ table: String) {
            self.table = table
        }
    }
    
    public struct Join: SQLSourceTableType {
        public enum JoinType {
            case inner, leftOuter, cross, natural, naturalLeftOuter
        }
        let left: SQLSourceTableType
        let type: JoinType
        let right: SQLSourceTableType
        let on: SQLConditionType?
    }
    
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


