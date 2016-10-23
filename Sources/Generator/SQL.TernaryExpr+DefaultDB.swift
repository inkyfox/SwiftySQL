//
//  SQL.TernaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.TernaryExpr {
    
    fileprivate func isParenthesesNecessary(_ expr: SQLExprType) -> Bool {
        return expr is SQLOperaorExprType
    }
    
}

extension SQL.TernaryExpr {
    
    class Generator: SQLElementGenerator<SQL.TernaryExpr> {
        
        override func generate(_ element: SQL.TernaryExpr) -> String {
            var query: String
            
            let lhs = element.lhs
            
            if element.isParenthesesNecessary(lhs) {
                query = "(\(lhs.sqlString(by: generator)))"
            } else {
                query = lhs.sqlString(by: generator)
            }
            
            query += " \(element.lop) "
            
            let chs = element.chs
            
            if element.isParenthesesNecessary(chs) {
                query += "(\(chs.sqlString(by: generator)))"
            } else {
                query += chs.sqlString(by: generator)
            }
            
            query += " \(element.rop) "
            
            let rhs = element.rhs
            
            if element.isParenthesesNecessary(rhs) {
                query += "(\(rhs.sqlString(by: generator)))"
            } else {
                query += rhs.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.TernaryExpr,
                                        withIndent indent: Int) -> String {
            var query: String
            
            let lhs = element.lhs
            
            if element.isParenthesesNecessary(lhs) {
                query = "( \(lhs.formattedSQLString(withIndent: indent + 2, by: generator)) )"
            } else {
                query = lhs.formattedSQLString(withIndent: indent, by: generator)
            }
            
            query += " \(element.lop) "
            let lind = indent + query.characters.count
            
            let chs = element.chs
            
            if element.isParenthesesNecessary(chs) {
                query += "( \(chs.formattedSQLString(withIndent: lind + 2, by: generator)) )"
            } else {
                query += chs.formattedSQLString(withIndent: lind, by: generator)
            }
            
            query += " \(element.rop) "
            let rind = indent + query.characters.count
            
            let rhs = element.rhs
            
            if element.isParenthesesNecessary(rhs) {
                query += "( \(rhs.formattedSQLString(withIndent: rind + 2, by: generator)) )"
            } else {
                query += rhs.formattedSQLString(withIndent: rind, by: generator)
            }
            
            return query
        }
        
        
    }
    
}
