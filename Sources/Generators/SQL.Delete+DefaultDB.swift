//
//  SQL.Delete+DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Delete {
    
    class Generator: SQLQueryGenerator<SQL.Delete> {
        
        override func generate(_ element: SQL.Delete) -> String {
            return generateQuery(element)
        }
        
        override func generateFormatted(_ element: SQL.Delete, withIndent indent: Int) -> String {
            return generateFormattedQuery(element, withIndent: indent)
        }
        
        override func generateQuery(_ element: SQL.Delete) -> String {
            var query = "DELETE FROM " + element.table.sqlString(by: generator)

            if let condition = element.condition {
                query += " WHERE " + condition.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormattedQuery(_ element: SQL.Delete, withIndent indent: Int) -> String {
            var query = "DELETE FROM " + element.table.formattedSQLString(withIndent: indent + 12, by: generator)
            
            if let condition = element.condition {
                query += "\n" + space(indent) + "WHERE  " + condition.formattedSQLString(withIndent: indent + 7,by: generator)
            }
            
            return query
        }
        
    }
    
}
