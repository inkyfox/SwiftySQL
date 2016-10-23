//
//  SQL.OpExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct OpExpr: SQLColumnType, SQLConditionType, SQLOrderType, SQLAliasable {
        let lhs: SQLExprType?
        let op: String
        let rhs: SQLExprType?
        
        public init(_ lhs: SQLExprType, _ op: String, _ rhs: SQLExprType) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }

        public init(_ lhs: SQLExprType, op: String) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = nil
        }
        
        public init(op: String, _ rhs: SQLExprType) {
            self.lhs = nil
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }

    }
    
}

extension SQLColumnType {
    
    public func eq(_ expr: SQLColumnType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "=", expr)
    }
    
    public func gt(_ expr: SQLColumnType) -> SQL.OpExpr {
        return SQL.OpExpr(self, ">", expr)
    }
    
    public func ge(_ expr: SQLColumnType) -> SQL.OpExpr {
        return SQL.OpExpr(self, ">=", expr)
    }
    
    public func lt(_ expr: SQLColumnType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "<", expr)
    }
    
    public func le(_ expr: SQLColumnType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "<=", expr)
    }
    
    public func ne(_ expr: SQLColumnType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "<>", expr)
    }
    
}

extension SQLConditionType {
    
    public func and(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "AND", expr)
    }
    
    public func or(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "OR", expr)
    }

    public func plus(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "+", expr)
    }
    
    public func minus(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "-", expr)
    }
    
    public func multiply(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "*", expr)
    }

    public func divide(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "/", expr)
    }

    public func mod(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "%", expr)
    }

    public func `is`(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "IS", expr)
    }

    public func isNot(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "IS NOT", expr)
    }

    public func concat(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "||", expr)
    }

    public func bitwiseAnd(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "|", expr)
    }
    
    public func bitwiseOr(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(self, "&", expr)
    }

}

extension SQLConditionType {
    
    public func isNull() -> SQL.OpExpr {
        return SQL.OpExpr(self, op: "ISNULL")
    }
    
    public func NotNull() -> SQL.OpExpr {
        return SQL.OpExpr(self, op: "NOTNULL")
    }
    
}

extension SQL {
    
    public static func not(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(op: "NOT", expr)
    }

    public static func minus(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(op: "-", expr)
    }
    
    public static func bitwiseNot(_ expr: SQLConditionType) -> SQL.OpExpr {
        return SQL.OpExpr(op: "~", expr)
    }

}
