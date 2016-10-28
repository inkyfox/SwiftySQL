//
//  SQLDeleteGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLDeleteGenerator: SQLQueryGenerator<SQLDelete> {
    
    override func generate(_ element: SQLDelete, forRead: Bool) -> String {
        return generateQuery(element, forRead: forRead)
    }
    
    override func generateFormatted(_ element: SQLDelete,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        return generateFormattedQuery(element, forRead: forRead, withIndent: indent)
    }
    
    override func generateQuery(_ element: SQLDelete, forRead: Bool) -> String {
        var query = "DELETE FROM " + element.table.sqlString(forRead: false, by: generator)
        
        if let condition = element.condition {
            query += " WHERE " + condition.sqlString(forRead: false, by: generator)
        }
        
        return query
    }
    
    override func generateFormattedQuery(_ element: SQLDelete,
                                         forRead: Bool,
                                         withIndent indent: Int) -> String {
        var query = "DELETE FROM "
        query += element.table.formattedSQLString(forRead: false,
                                                  withIndent: indent + 12,
                                                  by: generator)
        
        if let condition = element.condition {
            query += "\n"
            query += space(indent)
            query += "WHERE  "
            query += condition.formattedSQLString(forRead: false,
                                                  withIndent: indent + 7,
                                                  by: generator)
        }
        
        return query
    }
    
}
