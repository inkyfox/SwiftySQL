//
//  SQL.Delete.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public class Delete: SQLQueryType {
        
        let table: SQLSourceTableType
        var condition: SQLConditionType? = nil
        
        init(from table: SQLSourceTableType) {
            self.table = table
        }
        
    }
    
}

extension SQL.Delete {
    
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
    
    public static func delete(from table: SQLSourceTableType) -> Delete {
        return Delete(from: table)
    }
    
}

extension SQL.Delete {
    
    public func `where`(_ condition: SQLConditionType) -> SQL.Delete {
        self.condition = condition
        return self
    }
    
}
