//
//  SQLIn.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLIn: SQLOperaorExprType, SQLValueType, SQLConditionType, SQLAliasable {

    let expr: SQLExprType
    let isIn: Bool
    let table: SQLSourceTableType

    public init(_ expr: SQLExprType, in table: SQLSourceTableType) {
        self.expr = expr
        self.isIn = true
        self.table = table
    }
    
    public init(_ expr: SQLExprType, notIn table: SQLSourceTableType) {
        self.expr = expr
        self.isIn = false
        self.table = table
    }
    
}

extension SQLExprType {
    
    public func `in`(_ table: SQLSourceTableType) -> SQLIn {
        return SQLIn(self, in: table)
    }
    
    public func `in`(_ exprs: SQLExprType...) -> SQLIn {
        return SQLIn(self, in: SQLTuple(exprs))
    }
    
    public func notIn(_ table: SQLSourceTableType) -> SQLIn {
        return SQLIn(self, notIn: table)
    }
    
    public func notIn(_ exprs: SQLExprType...) -> SQLIn {
        return SQLIn(self, notIn: SQLTuple(exprs))
    }
    
}
