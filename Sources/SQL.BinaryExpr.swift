//
//  SQL.BinaryExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
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
    
}

extension SQLColumnType {
    
    public func eq(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "=", expr)
    }
    
    public func gt(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">", expr)
    }
    
    public func ge(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">=", expr)
    }
    
    public func lt(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<", expr)
    }
    
    public func le(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<=", expr)
    }
    
    public func ne(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<>", expr)
    }
    
}

extension SQLConditionType {
    
    public func and(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", expr)
    }
    
    public func or(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", expr)
    }
    
    
    
}

