//
//  SQL.SuffixUnaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.SuffixUnaryExpr {
    
    fileprivate func isParenthesesNecessary(_ expr: SQLExprType) -> Bool {
        return expr is SQLOperaorExprType
    }
    
}

extension SQL.SuffixUnaryExpr {
    
    class Generator: SQLElementGenerator<SQL.SuffixUnaryExpr> {
        
        override func generate(_ element: SQL.SuffixUnaryExpr) -> String {
            var query: String
            
            let lhs = element.lhs
            
            if element.isParenthesesNecessary(lhs) {
                query = "(\(lhs.sqlString(by: generator))) "
            } else {
                query = lhs.sqlString(by: generator) + " "
            }
            
            query += element.op

            return query
        }
        
        override func generateFormatted(_ element: SQL.SuffixUnaryExpr,
                                        withIndent indent: Int) -> String {
            var query: String
            
            let lhs = element.lhs

            if element.isParenthesesNecessary(lhs) {
                query = "( \(lhs.formattedSQLString(withIndent: indent + 2, by: generator)) )"
            } else {
                query = lhs.formattedSQLString(withIndent: indent, by: generator)
            }
        
            query += " \(element.op)"
            
            return query
        }
        
    }
    
}
