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
                ObjectIdentifier(SQLSelect.self)           : SQLSelectGenerator(),
                ObjectIdentifier(SQLInsert.self)           : SQLInsertGenerator(),
                ObjectIdentifier(SQLUpdate.self)           : SQLUpdateGenerator(),
                ObjectIdentifier(SQLDelete.self)           : SQLDeleteGenerator(),
                ObjectIdentifier(SQLColumn.self)           : SQLColumnGenerator(),
                ObjectIdentifier(SQLPrefixUnaryExpr.self)  : SQLPrefixUnaryExprGenerator(),
                ObjectIdentifier(SQLPostfixUnaryExpr.self) : SQLPostfixUnaryExprGenerator(),
                ObjectIdentifier(SQLBinaryExpr.self)       : SQLBinaryExprGenerator(),
                ObjectIdentifier(SQLTernaryExpr.self)      : SQLTernaryExprGenerator(),
                ObjectIdentifier(SQLTable.self)            : SQLTableGenerator(),
                ObjectIdentifier(SQLJoin.self)             : SQLJoinGenerator(),
                ObjectIdentifier(SQLOrder.self)            : SQLOrderGenerator(),
                ObjectIdentifier(SQLCase.self)             : SQLCaseGenerator(),
                ObjectIdentifier(SQLWhenThens.self)        : SQLWhenThensGenerator(),
                ObjectIdentifier(SQLFunc.self)             : SQLFuncGenerator(),
                ObjectIdentifier(SQLLimit.self)            : SQLLimitGenerator(),
                ObjectIdentifier(SQLAlias.self)            : SQLAliasGenerator(),
                ObjectIdentifier(SQLKeyword.self)          : SQLKeywordGenerator(),
                ObjectIdentifier(SQLHex.self)              : SQLHexGenerator(),
                ObjectIdentifier(SQLAsteriskMark.self)     : SQLAsteriskMarkGenerator(),
                ObjectIdentifier(SQLPreparedMark.self)     : SQLPreparedMarkGenerator(),
                ObjectIdentifier(SQLIn.self)               : SQLInGenerator(),
                ObjectIdentifier(SQLTuple.self)            : SQLTupleGenerator(),
                ObjectIdentifier(Int.self)                  : SQLIntGenerator(),
                ObjectIdentifier(Float.self)                : SQLFloatGenerator(),
                ObjectIdentifier(Double.self)               : SQLDoubleGenerator(),
                ObjectIdentifier(String.self)               : SQLStringGenerator(),
                ObjectIdentifier(Character.self)            : SQLCharacterGenerator(),
                ObjectIdentifier(Date.self)                 : SQLDateGenerator(),
            ]
        }
        
        for g in generators.values {
            g.setGenerator(self)
        }
        
    }

    func generate<T: SQLStringConvertible>(_ element: T, forRead: Bool) -> String {
        return (generators[ObjectIdentifier(T.self)]
            as? SQLElementGenerator<T>)?.generate(element, forRead: forRead) ?? ""
    }
    
    func generateFormatted<T: SQLStringConvertible>(_ element: T,
                           forRead: Bool,
                           withIndent indent: Int) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLElementGenerator<T>)?
            .generateFormatted(element, forRead: forRead, withIndent: indent) ?? ""
    }
    
    func generateQuery<T: SQLQueryType>(_ element: T, forRead: Bool) -> String {
        return (generators[ObjectIdentifier(T.self)]
            as? SQLQueryGenerator<T>)?.generateQuery(element, forRead: forRead) ?? ""
    }
    
    func generateFormattedQuery<T: SQLQueryType>(_ element: T,
                                forRead: Bool,
                                withIndent indent: Int) -> String {
        return (generators[ObjectIdentifier(T.self)] as? SQLQueryGenerator<T>)?
            .generateFormattedQuery(element, forRead: forRead, withIndent: indent) ?? ""
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

    func generate(_ element: T, forRead: Bool) -> String {
        return ""
    }
    
    func generateFormatted(_ element: T,
                           forRead: Bool,
                           withIndent indent: Int) -> String {
        return generate(element, forRead: forRead)
    }
    
}

class SQLQueryGenerator<T: SQLQueryType>: SQLElementGenerator<T> {

    func generateQuery(_ element: T, forRead: Bool) -> String {
        return ""
    }
    
    func generateFormattedQuery(_ element: T,
                                forRead: Bool,
                                withIndent indent: Int) -> String {
        return ""
    }
    
}
