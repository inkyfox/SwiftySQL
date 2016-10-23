//
//  SQL.BinaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.BinaryExpr {
    
    class Generator: SQLElementGenerator<SQL.BinaryExpr> {
        
        private let newLinedOperations = Set<String>(["AND", "OR"])
        
        override func generate(_ element: SQL.BinaryExpr) -> String {
            var l = element.lhs.sqlString(by: generator)
            if isParenthesesNecessary(element.lhs, for: element) {
                l = "(\(l))"
            }
            var r = element.rhs.sqlString(by: generator)
            if isParenthesesNecessary(element.rhs, for: element) {
                r = "(\(r))"
            }
            return "\(l) \(element.op) \(r)"
        }
        
        override func generateFormatted(_ element: SQL.BinaryExpr,
                                        withIndent indent: Int) -> String {
            let lhs = element.lhs
            let op = element.op
            let rhs = element.rhs
            
            var query = ""
            
            if isParenthesesNecessary(lhs, for: element) {
                query += "( \(lhs.formattedSQLString(withIndent: indent + 2, by: generator)) )"
            } else {
                query += lhs.formattedSQLString(withIndent: indent, by: generator)
            }
            
            let nextIndent: Int
            if newLinedOperations.contains(op) {
                let line = "\(space(indent))\(op) "
                query += "\n\(line)"
                nextIndent = line.characters.count
            } else {
                query += " \(op) "
                nextIndent = indent + query.characters.count
            }
            
            if isParenthesesNecessary(rhs, for: element) {
                query += "( \(rhs.formattedSQLString(withIndent: nextIndent + 2, by: generator)) )"
            } else {
                query += rhs.formattedSQLString(withIndent: nextIndent, by: generator)
            }
            
            return query
        }
        
        private func isParenthesesNecessary(_ expr: SQLExprType, for i: SQL.BinaryExpr) -> Bool {
            guard newLinedOperations.contains(i.op) else { return false }
            guard let b = expr as? SQL.BinaryExpr else { return false }
            guard newLinedOperations.contains(b.op) else { return false }
            return i.op != b.op
        }
        
    }

}
