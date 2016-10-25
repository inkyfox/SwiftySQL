//
//  SQL.SuffixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct SuffixUnaryExpr: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

        let lhs: SQLExprType
        let op: String
        
        public init(_ lhs: SQLExprType, op: String) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
        }
        
    }
    
}

extension SQLValueType {
    
    public func isNull() -> SQL.SuffixUnaryExpr {
        return SQL.SuffixUnaryExpr(self, op: "ISNULL")
    }
    
    public func isNotNull() -> SQL.SuffixUnaryExpr {
        return SQL.SuffixUnaryExpr(self, op: "NOTNULL")
    }
    
}
