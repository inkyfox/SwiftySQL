//
//  DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

struct DefaultDB {
    
    class SelectGenerator: SQLQueryGenerator<SQL.Select> {

        override func generate(_ element: SQL.Select) -> String {
            return "(\(generateQuery(element)))"
        }
        
        override func generateFormatted(_ element: SQL.Select, withIndent indent: Int) -> String {
            return "( \(generateFormattedQuery(element, withIndent: indent + 2)) )"
        }
        
        override func generateQuery(_ element: SQL.Select) -> String {
        
            var query = ""
            
            if element.columns.count > 0 {
                query += "SELECT " + join(element.columns, by: generator)
            }
            
            if element.tables.count > 0 {
                query += " FROM " + join(element.tables, by: generator)
            }
            
            if let condition = element.condition {
                query += " WHERE " + condition.sqlString(by: generator)
            }
            
            if element.groups.count > 0 {
                query += " GROUP BY " + join(element.groups, by: generator)
            }
            
            if let having = element.having {
                query += " HAVING " + having.sqlString(by: generator)
            }
            
            if element.orders.count > 0 {
                query += " ORDER BY " + join(element.orders, by: generator)
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
                query += formattedJoin(element.columns, withIndent: indent + 7, by: generator)
            } else {
                query += "SELECT *"
            }
            
            if element.tables.count > 0 {
                query += "\n\(space(indent))FROM   "
                query += formattedJoin(element.tables, withIndent: indent + 7, by: generator)
            }
            
            if let condition = element.condition {
                query += "\n\(space(indent))WHERE  "
                query += condition.formattedSQLString(withIndent: indent + 7, by: generator)
            }
            
            if element.groups.count > 0 {
                query += "\n\(space(indent))GROUP  BY "
                query += formattedJoin(element.groups, withIndent: indent + 10, by: generator)
            }
            
            if let having = element.having {
                query += "\n\(space(indent))HAVING "
                query += having.formattedSQLString(withIndent: indent + 7, by: generator)
            }
            
            if element.orders.count > 0 {
                query += "\n\(space(indent))ORDER  BY "
                query += formattedJoin(element.orders, withIndent: indent + 10, by: generator)
            }
            
            if let limit = element.limit {
                query += "\n\(space(indent))LIMIT  "
                query += limit.formattedSQLString(withIndent: indent + 7, by: generator)
            }
            
            return query
        }
        
    }
    
    class ColumnGenerator: SQLElementGenerator<SQL.Column> {
        
        override func generate(_ element: SQL.Column) -> String {
            if let t = element.tableName {
                return "\(t).\(element.columnName)"
            } else {
                return element.columnName
            }
        }

    }
    
    class BinaryExprGenerator: SQLElementGenerator<SQL.BinaryExpr> {

        private let newLinedOperations = Set<String>(["AND", "OR"])

        override func generate(_ element: SQL.BinaryExpr) -> String {
            var l = element.lhs.sqlString(by: generator)
            if isParenthesesNecessary(element.lhs, for: element) {
                l = "(\(l))"
            }
            var r = element.rhs.sqlString(by: generator)
            if isParenthesesNecessary(element.rhs, for: element) {
                r = "(\(r))"
            }
            return "\(l) \(element.op) \(r)"
        }
        
        override func generateFormatted(_ element: SQL.BinaryExpr,
                                      withIndent indent: Int) -> String {
            let lhs = element.lhs
            let op = element.op
            let rhs = element.rhs
            
            var query = ""
            
            if isParenthesesNecessary(lhs, for: element) {
                query += "( \(lhs.formattedSQLString(withIndent: indent + 2, by: generator)) )"
            } else {
                query += lhs.formattedSQLString(withIndent: indent, by: generator)
            }
            
            let nextIndent: Int
            if newLinedOperations.contains(op) {
                let line = "\(space(indent))\(op) "
                query += "\n\(line)"
                nextIndent = line.characters.count
            } else {
                query += " \(op) "
                nextIndent = indent + query.characters.count
            }
            
            if isParenthesesNecessary(rhs, for: element) {
                query += "( \(rhs.formattedSQLString(withIndent: nextIndent + 2, by: generator)) )"
            } else {
                query += rhs.formattedSQLString(withIndent: nextIndent, by: generator)
            }
            
            return query
        }
        
        private func isParenthesesNecessary(_ expr: SQLExprType, for i: SQL.BinaryExpr) -> Bool {
            guard newLinedOperations.contains(i.op) else { return false }
            guard let b = expr as? SQL.BinaryExpr else { return false }
            guard newLinedOperations.contains(b.op) else { return false }
            return i.op != b.op
        }
        
    }
    
    class TableGenerator: SQLElementGenerator<SQL.Table> {
        
        override func generate(_ element: SQL.Table) -> String {
            return element.table
        }
        
    }
    
    class JoinGenerator: SQLElementGenerator<SQL.Join> {
        
        private func typeString(_ type: SQL.Join.JoinType) -> String {
            switch type {
            case .inner: return "JOIN"
            case .leftOuter: return "LEFT JOIN"
            case .cross: return "CROSS JOIN"
            case .natural: return "NATURAL JOIN"
            case .naturalLeftOuter: return "NATURAL LEFT JOIN"
            }
        }

        override func generate(_ element: SQL.Join) -> String {
            let join = "\(element.left.sqlString(by: generator)) \(typeString(element.type)) \(element.right.sqlString(by: generator))"
            
            if let on = element.on {
                return "\(join) ON \(on.sqlString(by: generator))"
            } else {
                return join
            }
        }
        
        override func generateFormatted(_ element: SQL.Join,
                                        withIndent indent: Int) -> String {
            let line0 = "\(element.left.formattedSQLString(withIndent: indent, by: generator))\n"
            var line1 = "\(space(indent))\(typeString(element.type)) "
            let line2Indent = line1.characters.count - 3
            line1 += "\(element.right.formattedSQLString(withIndent: indent + line1.characters.count, by: generator))"
            if let on = element.on {
                let line2 = "\n\(space(line2Indent))ON \(on.formattedSQLString(withIndent: indent + 3, by: generator))"
                return line0 + line1 + line2
            } else {
                return line0 + line1
            }
        }
    }

    class OrderGenerator: SQLElementGenerator<SQL.Order> {
        
        func sortString(_ sort: SQL.Order.Sort) -> String {
            switch sort {
            case .asc: return "ASC"
            case .desc:  return "DESC"
            }
        }
        
        override func generate(_ element: SQL.Order) -> String {
            return "\(element.column.sqlString(by: generator)) \(sortString(element.sort))"
        }
        
        override func generateFormatted(_ element: SQL.Order,
                                        withIndent indent: Int) -> String {
            return "\(element.column.formattedSQLString(withIndent: indent, by: generator)) \(sortString(element.sort))"
        }
    }
    
    class CaseGenerator: SQLElementGenerator<SQL.Case> {
        
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
    
    class FuncGenerator: SQLElementGenerator<SQL.Func> {
        
        override func generate(_ element: SQL.Func) -> String {
            if let arguments = element.args {
                let query = arguments
                    .map { $0.sqlString(by: generator) }
                    .joined(separator: ", ")
                return "\(element.name)(\(query))"
            } else {
                return "\(element.name)(*)"
            }
        }
        
        override func generateFormatted(_ element: SQL.Func,
                                        withIndent indent: Int) -> String {
            if let arguments = element.args {
                let query = arguments
                    .map { $0.formattedSQLString(withIndent: 0, by: generator) }
                    .joined(separator: ",\n\(space(indent))")
                return "\(element.name)(\(query))"
            } else {
                return "\(element.name)(*)"
            }
        }
    }
    
    class LimitGenerator: SQLElementGenerator<SQL.Limit> {
        
        override func generate(_ element: SQL.Limit) -> String {
            if let offset = element.offset {
                return "\(element.limit), \(offset)"
            } else {
                return "\(element.limit)"
            }
        }
        
    }
    
    class AliasGenerator: SQLElementGenerator<SQL.Alias> {
        
        override func generate(_ element: SQL.Alias) -> String {
            return "\(element.sql.sqlString(by: generator).parenthesesIfNeeded) AS \(element.alias)"
        }
       
        override func generateFormatted(_ element: SQL.Alias,
                                        withIndent indent: Int) -> String {
            if element.sql.sqlString(by: generator).needParentheses {
                return "( \(element.sql.formattedSQLString(withIndent: indent + 2, by: generator)) ) AS \(element.alias)"
            } else {
                return "\(element.sql.formattedSQLString(withIndent: indent, by: generator)) AS \(element.alias)"
            }
        }
        
    }

}

internal func join(_ sqls: [SQLStringConvertible], by generator: SQLGenerator) -> String {
    return sqls
        .map { $0.sqlString(by: generator) }
        .joined(separator: ", ")
}

internal func formattedJoin(_ sqls: [SQLStringConvertible],
                            withIndent indent: Int, by generator: SQLGenerator) -> String {
    return sqls
        .map { $0.formattedSQLString(withIndent: indent, by: generator) }
        .joined(separator: ",\n\(space(indent))")
}

