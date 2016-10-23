//
//  SQL.Case+DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Case {
    
    class Generator: SQLElementGenerator<SQL.Case> {
        
        override func generate(_ element: SQL.Case) -> String {
            var query = "CASE "
            
            for wt in element.whenThens {
                query += "WHEN \(wt.when.sqlString(by: generator)) THEN \(wt.then.sqlString(by: generator)) "
            }
            
            if let dv = element.defaultValue {
                query += "ELSE \(dv.sqlString(by: generator)) "
            }
            
            query += "END"
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.Case,
                                        withIndent indent: Int) -> String {
            var query = "CASE "
            
            let nextIndent = indent + 2 + 5
            for wt in element.whenThens {
                let when = "\n\(space(indent))  WHEN \(wt.when.formattedSQLString(withIndent: nextIndent, by: generator))"
                query +=  when + " THEN \(wt.then.formattedSQLString(withIndent: when.characters.count, by: generator)) "
            }
            
            if let dv = element.defaultValue {
                query += "\n\(space(indent))  ELSE \(dv.formattedSQLString(withIndent: nextIndent, by: generator)) "
            }
            
            query += "\n\(space(indent))END"
            
            return query
        }
    }
    
}
