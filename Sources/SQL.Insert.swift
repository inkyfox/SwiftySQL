//
//  SQL.Insert.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public class Insert: SQLQueryType {
        
//        public enum Command {
//            case insert, replace, insertOrReplace
//        }
//        
//        let command: Command
//        let table: Table
//        let columns: [Column]
        
    }
}

extension SQL.Insert {
    
    public func query(by generator: SQLGenerator) -> String {
        return generator.generateQuery(self)
    }
    
    public func formattedQuery(by generator: SQLGenerator) -> String {
        return generator.generateFormattedQuery(self)
    }
    
    public var description: String {
        return query(by: SQLGenerator.default)
    }
    
    public var debugDescription: String {
        return formattedQuery(by: SQLGenerator.default)
    }
    
}
