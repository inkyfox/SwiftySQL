//
//  SQLPrefixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLPrefixUnaryExpr: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {
    let op: String
    let rhs: SQLExprType

    public init(op: String, _ rhs: SQLExprType) {
        self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
        self.rhs = rhs
    }
    
}

extension SQL {
    
    public static func exists(_ select: SQLSelect) -> SQLPrefixUnaryExpr {
        return SQLPrefixUnaryExpr(op: "EXISTS", select)
    }

    
    public static func notExists(_ select: SQLSelect) -> SQLPrefixUnaryExpr {
        return SQLPrefixUnaryExpr(op: "NOT EXISTS", select)
    }

}

public prefix func !(value: SQLConditionType) -> SQLPrefixUnaryExpr {
    return SQLPrefixUnaryExpr(op: "NOT", value)
}

public prefix func -(value: SQLValueType) -> SQLPrefixUnaryExpr {
    return SQLPrefixUnaryExpr(op: "-", value)
}

public prefix func ~(value: SQLValueType) -> SQLPrefixUnaryExpr {
    return SQLPrefixUnaryExpr(op: "~", value)
}

public func exists(_ select: SQLSelect) -> SQLPrefixUnaryExpr {
    return SQL.exists(select)
}


public func notExists(_ select: SQLSelect) -> SQLPrefixUnaryExpr {
    return SQL.notExists(select)
}
