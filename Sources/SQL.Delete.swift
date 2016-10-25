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
        
        let table: Table
        var condition: SQLConditionType? = nil
        
        init(from table: Table) {
            self.table = table
        }
        
    }
    
}

extension SQL.Delete {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self)
    }
    
    public func formattedQuery(withIndent indent: Int = 0, by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self, withIndent: indent)
    }
    
    public var description: String {
        return query(by: SQLGenerator.default)
    }
    
    public var debugDescription: String {
        return formattedQuery(by: SQLGenerator.default)
    }
    
}

extension SQL {
    
    public static func delete(from table: Table) -> Delete {
        return Delete(from: table)
    }
    
}

extension SQL.Delete {
    
    public func `where`(_ condition: SQLConditionType) -> SQL.Delete {
        self.condition = condition
        return self
    }
    
}
