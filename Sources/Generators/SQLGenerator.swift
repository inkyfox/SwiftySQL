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
                ObjectIdentifier(SQL.Select.self)          : SQL.Select.Generator(),
                ObjectIdentifier(SQL.Insert.self)          : SQL.Insert.Generator(),
                ObjectIdentifier(SQL.Update.self)          : SQL.Update.Generator(),
                ObjectIdentifier(SQL.Delete.self)          : SQL.Delete.Generator(),
                ObjectIdentifier(SQL.Column.self)          : SQL.Column.Generator(),
                ObjectIdentifier(SQL.PrefixUnaryExpr.self) : SQL.PrefixUnaryExpr.Generator(),
                ObjectIdentifier(SQL.PostfixUnaryExpr.self) : SQL.PostfixUnaryExpr.Generator(),
                ObjectIdentifier(SQL.BinaryExpr.self)      : SQL.BinaryExpr.Generator(),
                ObjectIdentifier(SQL.TernaryExpr.self)     : SQL.TernaryExpr.Generator(),
                ObjectIdentifier(SQL.Table.self)           : SQL.Table.Generator(),
                ObjectIdentifier(SQL.Join.self)            : SQL.Join.Generator(),
                ObjectIdentifier(SQL.Order.self)           : SQL.Order.Generator(),
                ObjectIdentifier(SQL.Case.self)            : SQL.Case.Generator(),
                ObjectIdentifier(SQL.Func.self)            : SQL.Func.Generator(),
                ObjectIdentifier(SQL.Limit.self)           : SQL.Limit.Generator(),
                ObjectIdentifier(SQL.Alias.self)           : SQL.Alias.Generator(),
                ObjectIdentifier(SQL.Keyword.self)         : SQL.Keyword.Generator(),
                ObjectIdentifier(SQL.Hex.self)         : SQL.Hex.Generator(),
                ObjectIdentifier(SQL.AsteriskMark.self) : SQL.AsteriskMark.Generator(),
                ObjectIdentifier(SQL.PreparedMark.self) : SQL.PreparedMark.Generator(),
                ObjectIdentifier(SQL.In.self)              : SQL.In.Generator(),
                ObjectIdentifier(SQL.Tuple.self)           : SQL.Tuple.Generator(),
                ObjectIdentifier(Int.self)                 : Int.Generator(),
                ObjectIdentifier(Float.self)               : Float.Generator(),
                ObjectIdentifier(Double.self)              : Double.Generator(),
                ObjectIdentifier(String.self)              : String.Generator(),
                ObjectIdentifier(Character.self)           : Character.Generator(),
                ObjectIdentifier(Date.self)                : Date.Generator(),
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
    
    func generateFormattedQuery<T: SQLQueryType>(_ element: T, withIndent indent: Int) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLQueryGenerator<T>)?
            .generateFormattedQuery(element, withIndent: indent) ?? ""
    }
}

protocol SQLElementGeneratable: class {
    func setGenerator(_ generator: SQLGenerator)
}

class SQLElementGenerator<T: SQLStringConvertible>: NSObject, SQLElementGeneratable {
    
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
