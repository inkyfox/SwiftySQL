//
//  SQLDelete.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public class SQLDelete: SQLQueryType {
    
    let table: SQLSourceTableType
    var condition: SQLConditionType? = nil
    
    init(from table: SQLSourceTableType) {
        self.table = table
    }
    
}

extension SQLDelete {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self, forRead: false)
    }
    
    public func formattedQuery(withIndent indent: Int = 0, by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self, forRead: false, withIndent: indent)
    }
    
    public var description: String {
        return query(by: SQLGenerator.default)
    }
    
    public var debugDescription: String {
        return formattedQuery(by: SQLGenerator.default)
    }
    
}

extension SQL {
    
    public static func delete(from table: SQLSourceTableType) -> SQLDelete {
        return SQLDelete(from: table)
    }
    
}

extension SQLDelete {
    
    public func `where`(_ condition: SQLConditionType) -> SQLDelete {
        self.condition = condition
        return self
    }
    
}
