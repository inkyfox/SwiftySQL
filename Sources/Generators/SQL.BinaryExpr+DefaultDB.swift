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

private let precedences: [String: Int] = [
    "||" : 1,
    "*" : 2,  "/" : 2, "%" : 2,
    "+" : 3, "-" : 3,
    "<<" : 4, ">>" : 4, "&" : 4, "|" : 4,
    "<" : 5, "<=" : 5, ">" : 5, ">=" : 5,
    "=" : 6, "==" : 6, "!=" : 6, "<>" : 6, "IS" : 6, "IS NOT" : 6,
    "IN" : 6, "LIKE" : 6, "NOT LIKE" : 6,
    "AND" : 7,
    "OR" : 8
]

extension SQL.BinaryExpr {
    
    fileprivate func isParenthesesNecessary(_ expr: SQLExprType) -> Bool {
        guard let precedence = precedences[op] else { return expr.needBoxed }
        
        if let b = expr as? SQL.BinaryExpr {
            guard let p = precedences[b.op] else { return true }
            return precedence < p
        } else {
            return expr.needBoxed
        }
    }
    
}

extension SQL.BinaryExpr {
    
    class Generator: SQLElementGenerator<SQL.BinaryExpr> {
        
        override func generate(_ element: SQL.BinaryExpr, forRead: Bool) -> String {
            var query: String
            
            let lhs = element.lhs
            
            if element.isParenthesesNecessary(lhs) {
                query = lhs.sqlString(forRead: forRead, by: generator).boxed
            } else {
                query = lhs.sqlString(forRead: forRead, by: generator)
            }
            
            query += " \(element.op) "
            
            let rhs = element.rhs

            if element.isParenthesesNecessary(rhs) {
                query += rhs.sqlString(forRead: forRead, by: generator).boxed
            } else {
                query += rhs.sqlString(forRead: forRead, by: generator)
            }
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.BinaryExpr,
                                        forRead: Bool,
                                        withIndent indent: Int) -> String {
            var query: String

            let lhs = element.lhs

            if element.isParenthesesNecessary(lhs) {
                query = lhs.formattedSQLStringBoxed(forRead: forRead,
                                                    withIndent: indent,
                                                    by: generator)
            } else {
                query = lhs.formattedSQLString(forRead: forRead,
                                               withIndent: indent,
                                               by: generator)
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
                query += rhs.formattedSQLStringBoxed(forRead: forRead,
                                                     withIndent: nextIndent,
                                                     by: generator)
            } else {
                query += rhs.formattedSQLString(forRead: forRead,
                                                withIndent: nextIndent,
                                                by: generator)
            }
            
            return query
        }
        
        
    }

}
