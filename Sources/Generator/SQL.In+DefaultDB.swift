//
//  SQL.In.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.In {
    
    fileprivate func isParenthesesNecessary(_ expr: SQLStringConvertible) -> Bool {
        return expr is SQLOperaorExprType
    }
    
}

extension SQL.In {
    
    class Generator: SQLElementGenerator<SQL.In> {
        
        override func generate(_ element: SQL.In) -> String {
            var query: String
            
            let expr = element.expr
            
            if element.isParenthesesNecessary(expr) {
                query = "(\(expr.sqlString(by: generator)))"
            } else {
                query = expr.sqlString(by: generator)
            }
            
            query += element.isIn ? " IN " : " NOT IN "
            
            let table = element.table
            
            if element.isParenthesesNecessary(table) {
                query += "(\(table.sqlString(by: generator)))"
            } else {
                query += table.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.In,
                                        withIndent indent: Int) -> String {
            var query: String
            
            let expr = element.expr
            
            if element.isParenthesesNecessary(expr) {
                query = "( \(expr.formattedSQLString(withIndent: indent + 2, by: generator)) )"
            } else {
                query = expr.formattedSQLString(withIndent: indent, by: generator)
            }
            
            query += element.isIn ? " IN " : " NOT IN "
            let nextIndent = indent + query.characters.count
            
            let table = element.table
            
            if element.isParenthesesNecessary(table) {
                query += "( \(table.formattedSQLString(withIndent: nextIndent + 2, by: generator)) )"
            } else {
                query += table.formattedSQLString(withIndent: nextIndent, by: generator)
            }
            
            return query
        }
        
        
    }
    
}
