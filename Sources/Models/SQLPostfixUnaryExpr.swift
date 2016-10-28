//
//  SQLPostfixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLPostfixUnaryExpr: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

    let lhs: SQLExprType
    let op: String

    public init(_ lhs: SQLExprType, op: String) {
        self.lhs = lhs
        self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
    }
    
}

extension SQLValueType {
    
    public var isNull: SQLPostfixUnaryExpr {
        return SQLPostfixUnaryExpr(self, op: "ISNULL")
    }
    
    public var isNotNull: SQLPostfixUnaryExpr {
        return SQLPostfixUnaryExpr(self, op: "NOTNULL")
    }
    
}
