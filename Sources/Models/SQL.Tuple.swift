//
//  SQL.Tuple.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Tuple: SQLSourceTableType, SQLAliasable {
        
        let exprs: [SQLExprType]
        
        public init(_ exprs: [SQLExprType]) {
            self.exprs = exprs
        }
        
        public init(_ expr: SQLExprType) {
            self.exprs = [expr]
        }

        public init(_ exprs: SQLExprType...) {
            self.exprs = exprs
        }
    }
    
}
