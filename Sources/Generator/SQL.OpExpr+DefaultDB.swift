//
//  SQL.OpExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

private let newLinedOperators = Set<String>(["AND", "OR"])
private let trimmedUnaryOperators = Set<String>(["+", "-", "~"])

extension SQL.OpExpr {
    
    fileprivate var isBinary: Bool { return lhs != nil && rhs != nil }
    
    fileprivate func isParenthesesNecessary(_ expr: SQLExprType) -> Bool {
        let isOpExpr = expr is SQL.OpExpr

        guard isBinary else { return isOpExpr }
        guard newLinedOperators.contains(op) else { return isOpExpr }

        guard let b = expr as? SQL.OpExpr else { return false }
        guard b.isBinary else { return false }
        guard newLinedOperators.contains(b.op) else { return false }

        return op != b.op
    }
    
}

extension SQL.OpExpr {
    
    class Generator: SQLElementGenerator<SQL.OpExpr> {
        
        override func generate(_ element: SQL.OpExpr) -> String {
            var query = ""
            
            if let lhs = element.lhs {
                if element.isParenthesesNecessary(lhs) {
                    query += "(\(lhs.sqlString(by: generator))) "
                } else {
                    query += lhs.sqlString(by: generator) + " "
                }
            }
            
            query += element.op
            
            if let rhs = element.rhs {
                if element.lhs != nil || !trimmedUnaryOperators.contains(element.op) {
                    query += " "
                }
                
                if element.isParenthesesNecessary(rhs) {
                    query += "(\(rhs.sqlString(by: generator)))"
                } else {
                    query += rhs.sqlString(by: generator)
                }
            }
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.OpExpr,
                                        withIndent indent: Int) -> String {
            var query = ""

            if let lhs = element.lhs {
                if element.isParenthesesNecessary(lhs) {
                    query += "( \(lhs.formattedSQLString(withIndent: indent + 2, by: generator)) )"
                } else {
                    query += lhs.formattedSQLString(withIndent: indent, by: generator)
                }
            }

            var nextIndent: Int
            if newLinedOperators.contains(element.op) {
                let line = "\(space(indent))\(element.op)"
                query += "\n\(line)"
                nextIndent = line.characters.count
            } else {
                if element.lhs != nil { query += " " }
                query += "\(element.op)"
                nextIndent = indent + query.characters.count
            }
            
            if let rhs = element.rhs {
                if element.lhs != nil || !trimmedUnaryOperators.contains(element.op) {
                    query += " "
                    nextIndent += 1
                }

                if element.isParenthesesNecessary(rhs) {
                    query += "( \(rhs.formattedSQLString(withIndent: nextIndent + 2, by: generator)) )"
                } else {
                    query += rhs.formattedSQLString(withIndent: nextIndent, by: generator)
                }
            }
            
            return query
        }
        
        
    }

}
