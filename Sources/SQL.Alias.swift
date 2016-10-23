//
//  SQL.Alias.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    open class Alias: SQLColumnType, SQLSourceTableType {
        let sql: SQLAliasable
        let alias: String
        
        public init(_ sql: SQLAliasable, alias: String) {
            self.sql = sql
            self.alias = alias
        }
        
    }
    
}

extension SQL.Alias {
    
    public func `as`(_ alias: String) -> SQL.Alias {
        return SQL.Alias(sql, alias: alias)
    }
    
}

extension SQLAliasable {
    
    public func `as`(_ alias: String) -> SQL.Alias {
        return SQL.Alias(self, alias: alias)
    }
    
}

