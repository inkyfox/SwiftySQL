//
//  SQL.In.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct In: SQLOperaorExprType, SQLValueType, SQLConditionType, SQLAliasable {
        
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
    
}


extension SQLExprType {
    
    public func `in`(_ table: SQLSourceTableType) -> SQL.In {
        return SQL.In(self, in: table)
    }
    
    public func notIn(_ table: SQLSourceTableType) -> SQL.In {
        return SQL.In(self, notIn: table)
    }
    
}
