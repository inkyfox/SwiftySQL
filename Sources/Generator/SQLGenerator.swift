//
//  SQLGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public class SQLGenerator {
    
    public enum DB {
        case sqlite3
    }
    
    public static let `default`: SQLGenerator = SQLGenerator(db: .sqlite3)
    public static let sqlite3: SQLGenerator = SQLGenerator(db: .sqlite3)
    
    fileprivate let generators: [ObjectIdentifier : SQLElementGeneratable]
    
    fileprivate init(db: DB) {
        switch db {
        default:
            generators = [
                ObjectIdentifier(SQL.Select.self)     : DefaultDB.SelectGenerator(),
                ObjectIdentifier(SQL.Column.self)     : DefaultDB.ColumnGenerator(),
                ObjectIdentifier(SQL.BinaryExpr.self) : DefaultDB.BinaryExprGenerator(),
                ObjectIdentifier(SQL.Table.self)      : DefaultDB.TableGenerator(),
                ObjectIdentifier(SQL.Join.self)       : DefaultDB.JoinGenerator(),
                ObjectIdentifier(SQL.Order.self)      : DefaultDB.OrderGenerator(),
                ObjectIdentifier(SQL.Case.self)       : DefaultDB.CaseGenerator(),
                ObjectIdentifier(SQL.Func.self)       : DefaultDB.FuncGenerator(),
                ObjectIdentifier(SQL.Limit.self)      : DefaultDB.LimitGenerator(),
                ObjectIdentifier(SQL.Alias.self)      : DefaultDB.AliasGenerator(),
            ]
        }
        
        for g in generators.values {
            g.setGenerator(self)
        }
        
    }

    func generate<T: SQLStringConvertible>(_ element: T) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLElementGenerator<T>)?.generate(element) ?? ""
    }
    
    func generateFormatted<T: SQLStringConvertible>(_ element: T,
                           withIndent indent: Int) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLElementGenerator<T>)?
            .generateFormatted(element, withIndent: indent) ?? ""
    }
    
    func generateQuery<T: SQLQueryType>(_ element: T) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLQueryGenerator<T>)?.generateQuery(element) ?? ""
    }
    
    func generateFormattedQuery<T: SQLQueryType>(_ element: T) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLQueryGenerator<T>)?
            .generateFormattedQuery(element, withIndent: 0) ?? ""
    }
}

protocol SQLElementGeneratable: class {
    func setGenerator(_ generator: SQLGenerator)
}

class SQLElementGenerator<T: SQLStringConvertible>: SQLElementGeneratable {
    
    var generator: SQLGenerator!
    
    func setGenerator(_ generator: SQLGenerator) {
        self.generator = generator
    }

    func generate(_ element: T) -> String {
        return ""
    }
    
    func generateFormatted(_ element: T,
                           withIndent indent: Int) -> String {
        return generate(element)
    }
    
}

class SQLQueryGenerator<T: SQLQueryType>: SQLElementGenerator<T> {

    func generateQuery(_ element: T) -> String {
        return ""
    }
    
    func generateFormattedQuery(_ element: T, withIndent indent: Int) -> String {
        return ""
    }
    
}
