//
//  SQL.Select+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Select {
    
    class Generator: SQLQueryGenerator<SQL.Select> {
        
        override func generate(_ element: SQL.Select) -> String {
            return generateQuery(element).boxed
        }
        
        override func generateFormatted(_ element: SQL.Select, withIndent indent: Int) -> String {
            return generateFormattedQuery(element, withIndent: indent + 2).boxedWithSpace
        }
        
        override func generateQuery(_ element: SQL.Select) -> String {
            var query = ""
            
            if element.columns.count > 0 {
                query += "SELECT " + sqlJoin(element.columns, by: generator)
            }
            
            if element.tables.count > 0 {
                query += " FROM " + sqlJoin(element.tables, by: generator)
            }
            
            if let condition = element.condition {
                query += " WHERE " + condition.sqlString(by: generator)
            }
            
            if element.groups.count > 0 {
                query += " GROUP BY " + sqlJoin(element.groups, by: generator)
            }
            
            if let having = element.having {
                query += " HAVING " + having.sqlString(by: generator)
            }
            
            if element.orders.count > 0 {
                query += " ORDER BY " + sqlJoin(element.orders, by: generator)
            }
            
            if let limit = element.limit {
                query += " LIMIT " + limit.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormattedQuery(_ element: SQL.Select, withIndent indent: Int) -> String {
            
            var query = ""
            
            if element.columns.count > 0 {
                query += "SELECT "
                query += formattedSQLJoin(element.columns, withIndent: indent + 7, by: generator)
            } else {
                query += "SELECT *"
            }
            
            if element.tables.count > 0 {
                query += "\n\(space(indent))FROM   "
                query += formattedSQLJoin(element.tables, withIndent: indent + 7, by: generator)
            }
            
            if let condition = element.condition {
                query += "\n\(space(indent))WHERE  "
                query += condition.formattedSQLString(withIndent: indent + 7, by: generator)
            }
            
            if element.groups.count > 0 {
                query += "\n\(space(indent))GROUP  BY "
                query += formattedSQLJoin(element.groups, withIndent: indent + 10, by: generator)
            }
            
            if let having = element.having {
                query += "\n\(space(indent))HAVING "
                query += having.formattedSQLString(withIndent: indent + 7, by: generator)
            }
            
            if element.orders.count > 0 {
                query += "\n\(space(indent))ORDER  BY "
                query += formattedSQLJoin(element.orders, withIndent: indent + 10, by: generator)
            }
            
            if let limit = element.limit {
                query += "\n\(space(indent))LIMIT  "
                query += limit.formattedSQLString(withIndent: indent + 7, by: generator)
            }
            
            return query
        }
       
    }
    
}
