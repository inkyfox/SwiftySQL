//
//  SQL.Insert+DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Insert {
    
    class Generator: SQLQueryGenerator<SQL.Insert> {
        
        func actionString(_ action: SQL.Insert.Action) -> String {
            switch action {
            case .insert: return "INSERT"
            case .replace: return "REPLACE"
            case .insertOrReplace: return "INSERT OR REPLACE"
            case .insertOrRollback: return "INSERT OR ROLLBACK"
            case .insertOrAbort: return "INSERT OR ABORT"
            case .insertOrFail: return "INSERT OR FAIL"
            case .insertOrIgnore: return "INSERT OR IGNORE"
            }
        }
        
        override func generate(_ element: SQL.Insert) -> String {
            return generateQuery(element)
        }
        
        override func generateFormatted(_ element: SQL.Insert, withIndent indent: Int) -> String {
            return generateFormattedQuery(element, withIndent: indent)
        }
        
        override func generateQuery(_ element: SQL.Insert) -> String {
            var query = actionString(element.action) + " INTO "
            query += element.table.sqlString(by: generator) + " "
            query += element.columns.map { $0.columnName }.joined(separator: ", ").boxed + " "
            
            if element.values.count > 0 {
                query += "VALUES "
                query += element.values.map { sqlJoin($0, by: generator).boxed }.joined(separator: ", ")
            } else if let select = element.select {
                query += select.query(by: generator)
            } else {
                query += "DEFAULT VALUES"
            }
            
            return query
        }
        
        override func generateFormattedQuery(_ element: SQL.Insert, withIndent indent: Int) -> String {
            var query = actionString(element.action) + " INTO "
            
            let paramIndent = indent + query.characters.count
            
            query += element.table.formattedSQLString(withIndent: paramIndent, by: generator)
            query += "\n\(space(paramIndent))"
            query += element.columns.map { $0.columnName }.joined(separator: ", ").boxedWithSpace + "\n"
            //query += element.columns.map { $0.columnName }.joined(separator: ",\n" + space(paramIndent + 2)).boxedWithSpace + "\n"
            
            if element.values.count > 0 {
                query += space(indent) + "VALUES" + space(paramIndent - indent - 6)
                query += element.values
                    .map { formattedSQLJoinBoxed($0, withIndent: paramIndent, by: generator) }
                    .joined(separator: ",\n" + space(paramIndent))
            } else if let select = element.select {
                query += space(indent) + select.formattedQuery(withIndent: indent, by: generator)
            } else {
                query += space(indent) + "DEFAULT VALUES"
            }
            
            return query
        }
        
    }
    
}
