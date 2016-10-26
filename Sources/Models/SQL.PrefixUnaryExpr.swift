//
//  SQL.PrefixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct PrefixUnaryExpr: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

        let op: String
        let rhs: SQLExprType
        
        public init(op: String, _ rhs: SQLExprType) {
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }
        
    }
    
}

extension SQL {
    
    public static func exists(_ select: SQL.Select) -> SQL.PrefixUnaryExpr {
        return SQL.PrefixUnaryExpr(op: "EXISTS", select)
    }

    
    public static func notExists(_ select: SQL.Select) -> SQL.PrefixUnaryExpr {
        return SQL.PrefixUnaryExpr(op: "NOT EXISTS", select)
    }

}

public prefix func !(value: SQLConditionType) -> SQL.PrefixUnaryExpr {
    return SQL.PrefixUnaryExpr(op: "NOT", value)
}

public prefix func -(value: SQLValueType) -> SQL.PrefixUnaryExpr {
    return SQL.PrefixUnaryExpr(op: "-", value)
}

public prefix func ~(value: SQLValueType) -> SQL.PrefixUnaryExpr {
    return SQL.PrefixUnaryExpr(op: "~", value)
}

public func exists(_ select: SQL.Select) -> SQL.PrefixUnaryExpr {
    return SQL.exists(select)
}


public func notExists(_ select: SQL.Select) -> SQL.PrefixUnaryExpr {
    return SQL.notExists(select)
}
