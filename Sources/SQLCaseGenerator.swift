//
//  SQLCaseGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLWhenThensGenerator: SQLElementGenerator<SQLWhenThens> {
    
    override func generate(_ element: SQLWhenThens, forRead: Bool) -> String {
        var query = "CASE "
        
        for wt in element.whenThens {
            query +=
                "WHEN \(wt.when.sqlString(forRead: forRead, by: generator)) "
                + "THEN \(wt.then.sqlString(forRead: forRead, by: generator)) "
        }
        
        query += "END"
        
        return query
    }
    
    override func generateFormatted(_ element: SQLWhenThens,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        var query = "CASE "
        
        let nextIndent = indent + 2 + 5
        for wt in element.whenThens {
            let when = "\n\(space(indent))  WHEN "
                + wt.when.formattedSQLString(forRead: forRead,
                                             withIndent: nextIndent,
                                             by: generator)
            query +=  when + " THEN "
                + wt.then.formattedSQLString(forRead: forRead,
                                             withIndent: when.characters.count,
                                             by: generator)
                + " "
        }
        
        query += "\n\(space(indent))END"
        
        return query
    }
}

class SQLCaseGenerator: SQLElementGenerator<SQLCase> {
    
    override func generate(_ element: SQLCase, forRead: Bool) -> String {
        var query = "CASE "
        
        for wt in element.whenThens.whenThens {
            query += "WHEN "
                + wt.when.sqlString(forRead: forRead, by: generator)
                + " THEN "
                + wt.then.sqlString(forRead: forRead, by: generator)
                + " "
        }
        
        if let dv = element.defaultValue {
            query += "ELSE " + dv.sqlString(forRead: forRead, by: generator) + " "
        }
        
        query += "END"
        
        return query
    }
    
    override func generateFormatted(_ element: SQLCase,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        var query = "CASE "
        
        let nextIndent = indent + 2 + 5
        for wt in element.whenThens.whenThens {
            let when = "\n"
                + space(indent) + "  WHEN "
                + wt.when.formattedSQLString(forRead: forRead,
                                             withIndent: nextIndent,
                                             by: generator)
            query += when + " THEN "
                + wt.then.formattedSQLString(forRead: forRead,
                                             withIndent: when.characters.count,
                                             by: generator)
                + " "
        }
        
        if let dv = element.defaultValue {
            query += "\n"
                + space(indent)
                + "  ELSE "
                + dv.formattedSQLString(forRead: forRead, withIndent: nextIndent, by: generator)
                + " "
        }
        
        query += "\n\(space(indent))END"
        
        return query
    }

}

