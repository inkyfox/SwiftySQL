//
//  SQLSelectGenerator.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLSelectGenerator: SQLQueryGenerator<SQLSelect> {
    
    override func generate(_ element: SQLSelect, forRead: Bool) -> String {
        return generateQuery(element, forRead: forRead).boxed
    }
    
    override func generateFormatted(_ element: SQLSelect,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        return generateFormattedQuery(element,
                                      forRead: forRead,
                                      withIndent: indent + 2).boxedWithSpace
    }
    
    override func generateQuery(_ element: SQLSelect, forRead: Bool) -> String {
        var query = ""
        
        if element.columns.count > 0 {
            query += "SELECT " + sqlJoin(element.columns, forRead: true, by: generator)
        } else {
            query += "SELECT *"
        }
        
        if element.tables.count > 0 {
            query += " FROM " + sqlJoin(element.tables, forRead: true, by: generator)
        }
        
        if let condition = element.condition {
            query += " WHERE " + condition.sqlString(forRead: true, by: generator)
        }
        
        if element.groups.count > 0 {
            query += " GROUP BY " + sqlJoin(element.groups, forRead: true, by: generator)
        }
        
        if let having = element.having {
            query += " HAVING " + having.sqlString(forRead: true, by: generator)
        }
        
        if element.orders.count > 0 {
            query += " ORDER BY " + sqlJoin(element.orders, forRead: true, by: generator)
        }
        
        if let limit = element.limit {
            query += " LIMIT " + limit.sqlString(forRead: true, by: generator)
        }
        
        return query
    }
    
    override func generateFormattedQuery(_ element: SQLSelect,
                                         forRead: Bool,
                                         withIndent indent: Int) -> String {
        
        var query = ""
        
        if element.columns.count > 0 {
            query += "SELECT "
            query += formattedSQLJoin(element.columns,
                                      forRead: true,
                                      withIndent: indent + 7,
                                      by: generator)
        } else {
            query += "SELECT *"
        }
        
        if element.tables.count > 0 {
            query += "\n\(space(indent))FROM   "
            query += formattedSQLJoin(element.tables,
                                      forRead: true,
                                      withIndent: indent + 7,
                                      by: generator)
        }
        
        if let condition = element.condition {
            query += "\n\(space(indent))WHERE  "
            query += condition.formattedSQLString(forRead: true,
                                                  withIndent: indent + 7,
                                                  by: generator)
        }
        
        if element.groups.count > 0 {
            query += "\n\(space(indent))GROUP  BY "
            query += formattedSQLJoin(element.groups,
                                      forRead: true,
                                      withIndent: indent + 10,
                                      by: generator)
        }
        
        if let having = element.having {
            query += "\n\(space(indent))HAVING "
            query += having.formattedSQLString(forRead: true,
                                               withIndent: indent + 7,
                                               by: generator)
        }
        
        if element.orders.count > 0 {
            query += "\n\(space(indent))ORDER  BY "
            query += formattedSQLJoin(element.orders,
                                      forRead: true,
                                      withIndent: indent + 10,
                                      by: generator)
        }
        
        if let limit = element.limit {
            query += "\n\(space(indent))LIMIT  "
            query += limit.formattedSQLString(forRead: true,
                                              withIndent: indent + 7,
                                              by: generator)
        }
        
        return query
    }
    
}

