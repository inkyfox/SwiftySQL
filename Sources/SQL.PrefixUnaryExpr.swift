//
//  SQL.PrefixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct PrefixUnaryExpr: SQLOperaorExprType, SQLColumnType, SQLConditionType, SQLOrderType, SQLAliasable {

        let op: String
        let rhs: SQLExprType
        
        public init(op: String, _ rhs: SQLExprType) {
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }
        
    }
    
}

extension SQL {
    
    public static func not(_ expr: SQLConditionType) -> SQL.PrefixUnaryExpr {
        return SQL.PrefixUnaryExpr(op: "NOT", expr)
    }
    
    public static func minus(_ expr: SQLConditionType) -> SQL.PrefixUnaryExpr {
        return SQL.PrefixUnaryExpr(op: "-", expr)
    }
    
    public static func bitwiseNot(_ expr: SQLConditionType) -> SQL.PrefixUnaryExpr {
        return SQL.PrefixUnaryExpr(op: "~", expr)
    }
    
}
