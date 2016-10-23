//
//  SQL.TernaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct TernaryExpr: SQLOperaorExprType, SQLColumnType, SQLConditionType, SQLOrderType, SQLAliasable {
        
        let lhs: SQLExprType
        let lop: String
        let chs: SQLExprType
        let rop: String
        let rhs: SQLExprType
        
        public init(_ lhs: SQLExprType, _ lop: String, _ chs: SQLExprType, _ rop: String, _ rhs: SQLExprType) {
            self.lhs = lhs
            self.lop = lop.trimmingCharacters(in: whiteSpaces).uppercased()
            self.chs = chs
            self.rop = rop.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }
        
    }
    
}

extension SQLExprType {
    
    public func like(_ pattern: String, escape: String) -> SQL.TernaryExpr {
        return SQL.TernaryExpr(self, "LIKE", pattern, "ESCAPE", escape)
    }
    
    public func notLike(_ pattern: String, escape: String) -> SQL.TernaryExpr {
        return SQL.TernaryExpr(self, "NOT LIKE", pattern, "ESCAPE", escape)
    }

    public func between(_ from: SQLExprType, and to: SQLExprType) -> SQL.TernaryExpr {
        return SQL.TernaryExpr(self, "BETWEEN", from, "AND", to)
    }
    
    public func notBetween(_ from: SQLExprType, and to: SQLExprType) -> SQL.TernaryExpr {
        return SQL.TernaryExpr(self, "NOT BETWEEN", from, "AND", to)
    }

}
