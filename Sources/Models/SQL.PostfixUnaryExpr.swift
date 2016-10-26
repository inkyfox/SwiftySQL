//
//  SQL.PostfixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct PostfixUnaryExpr: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

        let lhs: SQLExprType
        let op: String
        
        public init(_ lhs: SQLExprType, op: String) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
        }
        
    }
    
}

extension SQLValueType {
    
    public var isNull: SQL.PostfixUnaryExpr {
        return SQL.PostfixUnaryExpr(self, op: "ISNULL")
    }
    
    public var isNotNull: SQL.PostfixUnaryExpr {
        return SQL.PostfixUnaryExpr(self, op: "NOTNULL")
    }
    
}
