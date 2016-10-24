//
//  SQL.OpExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct BinaryExpr: SQLOperaorExprType, SQLColumnType, SQLConditionType, SQLOrderType, SQLAliasable {

        let lhs: SQLExprType
        let op: String
        let rhs: SQLExprType
        
        public init(_ lhs: SQLExprType, _ op: String, _ rhs: SQLExprType) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }

        public init(_ lhs: SQLExprType, _ op: String, _ rhs: Literal) {
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

    public func plus(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "+", expr)
    }
    
    public func minus(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "-", expr)
    }
    
    public func multiply(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "*", expr)
    }

    public func divide(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "/", expr)
    }

    public func mod(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "%", expr)
    }

    public func `is`(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS", expr)
    }

    public func isNot(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS NOT", expr)
    }

    public func concat(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", expr)
    }

    public func bitwiseAnd(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "|", expr)
    }
    
    public func bitwiseOr(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "&", expr)
    }

}

extension SQLExprType {

    public func like(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", pattern)
    }
    
    public func notLike(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "NOT LIKE", pattern)
    }
 
    public func likeIgnoreCase(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper(pattern))
    }
    
    public func notLikeIgnoreCase(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "NOT LIKE", SQL.upper(pattern))
    }
    
    public func contains(_ substring: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "%\(substring)%")
    }
    
    public func hasPrefix(_ prefix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "\(prefix)%")
    }
    
    public func hasSuffix(_ suffix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "%\(suffix)")
    }
    
}

extension SQLExprType {
    
    public func eq(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "=", prepared)
    }
    
    public func gt(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">", prepared)
    }
    
    public func ge(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">=", prepared)
    }
    
    public func lt(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<", prepared)
    }
    
    public func le(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<=", prepared)
    }
    
    public func ne(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<>", prepared)
    }
}

extension SQLConditionType {
    
    public func and(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", prepared)
    }
    
    public func or(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", prepared)
    }
    
    public func plus(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "+", prepared)
    }
    
    public func minus(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "-", prepared)
    }
    
    public func multiply(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "*", prepared)
    }
    
    public func divide(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "/", prepared)
    }
    
    public func mod(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "%", prepared)
    }
    
    public func `is`(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS", prepared)
    }
    
    public func isNot(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS NOT", prepared)
    }
    
    public func concat(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", prepared)
    }
    
    public func bitwiseAnd(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "|", prepared)
    }
    
    public func bitwiseOr(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "&", prepared)
    }
    
}

extension SQLExprType {
    
    public func like(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", prepared)
    }
    
    public func notLike(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "NOT LIKE", prepared)
    }
    
    public func likeIgnoreCase(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper(prepared))
    }
    
    public func notLikeIgnoreCase(_ prepared: SQL.PreparedLiteral) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "NOT LIKE", SQL.upper(prepared))
    }
    
}


