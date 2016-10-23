//
//  SQL.BinaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

private let newLinedOperators = Set<String>(["AND", "OR"])
private let trimmedUnaryOperators = Set<String>(["+", "-", "~"])

extension SQL.BinaryExpr {
    
    fileprivate func isParenthesesNecessary(_ expr: SQLExprType) -> Bool {
        let isOpExpr = expr.needBoxed

        guard newLinedOperators.contains(op) else { return isOpExpr }

        guard let b = expr as? SQL.BinaryExpr else { return false }
        guard newLinedOperators.contains(b.op) else { return false }

        return op != b.op
    }
    
}

extension SQL.BinaryExpr {
    
    class Generator: SQLElementGenerator<SQL.BinaryExpr> {
        
        override func generate(_ element: SQL.BinaryExpr) -> String {
            var query: String
            
            let lhs = element.lhs
            
            if element.isParenthesesNecessary(lhs) {
                query = lhs.sqlString(by: generator).boxed
            } else {
                query = lhs.sqlString(by: generator)
            }
            
            query += " \(element.op) "
            
            let rhs = element.rhs

            if element.isParenthesesNecessary(rhs) {
                query += rhs.sqlString(by: generator).boxed
            } else {
                query += rhs.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.BinaryExpr,
                                        withIndent indent: Int) -> String {
            var query: String

            let lhs = element.lhs

            if element.isParenthesesNecessary(lhs) {
                query = lhs.formattedSQLString(withIndent: indent + 2, by: generator).boxedWithSpace
            } else {
                query = lhs.formattedSQLString(withIndent: indent, by: generator)
            }

            var nextIndent: Int
            if newLinedOperators.contains(element.op) {
                let line = "\(space(indent))\(element.op) "
                query += "\n\(line)"
                nextIndent = line.characters.count
            } else {
                query += " \(element.op) "
                nextIndent = indent + query.characters.count
            }
            
            let rhs = element.rhs

            if element.isParenthesesNecessary(rhs) {
                query += rhs.formattedSQLString(withIndent: nextIndent + 2, by: generator).boxedWithSpace
            } else {
                query += rhs.formattedSQLString(withIndent: nextIndent, by: generator)
            }
            
            return query
        }
        
        
    }

}
