//
//  SQL.Update+DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Update {
    
    class Generator: SQLQueryGenerator<SQL.Update> {
        
        func actionString(_ orAction: SQL.Update.OrAction?) -> String {
            guard let or = orAction else { return "UPDATE" }
            switch or {
            case .replace: return "UPDATE OR REPLACE"
            case .rollback: return "UPDATE OR ROLLBACK"
            case .abort: return "UPDATE OR ABORT"
            case .fail: return "UPDATE OR FAIL"
            case .ignore: return "UPDATE OR IGNORE"
            }
        }
        
        override func generate(_ element: SQL.Update) -> String {
            return generateQuery(element)
        }
        
        override func generateFormatted(_ element: SQL.Update, withIndent indent: Int) -> String {
            return generateFormattedQuery(element, withIndent: indent)
        }
        
        override func generateQuery(_ element: SQL.Update) -> String {
            var query = actionString(element.orAction) + " "
            query += element.table.sqlString(by: generator)
            query += " SET "
            query +=
                element.sets
                    .filter { $0.0.count > 0 && $0.1.count > 0 }
                    .map { (columns, values) -> String in
                        return (columns.count == 1 ?
                            columns[0].columnName :
                            columns.map { $0.columnName }.joined(separator: ", ").boxed)
                            + " = "
                            + (values.count == 1 ?
                                values[0].sqlString(by: generator) : sqlJoin(values, by: generator).boxed)
                    }
                    .joined(separator: ", ")
            
            if let condition = element.condition {
                query += " WHERE " + condition.sqlString(by: generator)
            }
            
            return query
        }
        
        override func generateFormattedQuery(_ element: SQL.Update, withIndent indent: Int) -> String {
            var query = actionString(element.orAction) + " "
            let paramIndent = indent + query.characters.count
            query += element.table.formattedSQLString(withIndent: paramIndent, by: generator) + "\n"
            query += space(indent) + "SET    "
            query +=
                element.sets
                    .filter { $0.0.count > 0 && $0.1.count > 0 }
                    .map { (columns, values) -> String in
                        
                        var query = (columns.count == 1 ?
                            columns[0].columnName :
                            columns.map { $0.columnName }.joined(separator: ", ").boxedWithSpace)
                        //columns.map { $0.columnName }.joined(separator: ",\n" + space(paramIndent + 2)).boxedWithSpace + "\n"
                        
                        let needNewLine = values.count > 1 || values[0] is SQL.Select
                        let rhsIndent: Int
                        if needNewLine {
                            query += " =\n"
                            rhsIndent = paramIndent + 2
                            query += space(rhsIndent)
                        } else {
                            query += " = "
                            rhsIndent = paramIndent + query.characters.count
                        }
                        query += (values.count == 1 ?
                            values[0].formattedSQLString(withIndent: rhsIndent, by: generator) :
                            formattedSQLJoinBoxed(values, withIndent: rhsIndent, by: generator))

                        return query
                    }
                    .joined(separator: ",\n" + space(paramIndent))
            
            if let condition = element.condition {
                query += "\n" + space(indent) + "WHERE  " + condition.formattedSQLString(withIndent: indent + 7,by: generator)
            }
            
            return query
        }
        
    }
    
}
