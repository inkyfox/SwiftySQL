//
//  SQL.PrefixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

private let trimmedUnaryOperators = Set<String>(["+", "-", "~"])

extension SQL.PrefixUnaryExpr {
    
    fileprivate func isParenthesesNecessary(_ expr: SQLExprType) -> Bool {
        return expr is SQLOperaorExprType
    }
    
}

extension SQL.PrefixUnaryExpr {
    
    class Generator: SQLElementGenerator<SQL.PrefixUnaryExpr> {
        
        override func generate(_ element: SQL.PrefixUnaryExpr) -> String {
            
            var query = element.op
            
            if !trimmedUnaryOperators.contains(element.op) {
                query += " "
            }
            
            let rhs = element.rhs

            if element.isParenthesesNecessary(rhs) {
                query += "(\(rhs.sqlString(by: generator)))"
            } else {
                query += rhs.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.PrefixUnaryExpr,
                                        withIndent indent: Int) -> String {
            var query = "\(element.op)"
            
            var nextIndent = indent + query.characters.count
            
            if !trimmedUnaryOperators.contains(element.op) {
                query += " "
                nextIndent += 1
            }
            
            let rhs = element.rhs

            if element.isParenthesesNecessary(rhs) {
                query += "( \(rhs.formattedSQLString(withIndent: nextIndent + 2, by: generator)) )"
            } else {
                query += rhs.formattedSQLString(withIndent: nextIndent, by: generator)
            }
            
            return query
        }
        
        
    }
    
}

