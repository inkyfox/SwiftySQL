//
//  SQL.Case.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Case: SQLColumnType, SQLOrderType, SQLAliasable {
        struct When  {
            let when: SQLExprType
            let then: SQLExprType
            init(_ when: SQLExprType, then: SQLExprType) {
                self.when = when
                self.then = then
            }
        }
        
        let whenThens: [When]
        let defaultValue: SQLExprType?
        
        public init(when: SQLExprType, then: SQLExprType, else defaultValue: SQLExprType? = nil) {
            self.whenThens = [When(when, then: then)]
            self.defaultValue = defaultValue
        }
        
        public init(_ whenthens: [(when: SQLExprType, then: SQLExprType)], else defaultValue: SQLExprType? = nil) {
            self.whenThens = whenthens.map { When($0.0, then: $0.1) }
            self.defaultValue = defaultValue
        }
    }
    
}
