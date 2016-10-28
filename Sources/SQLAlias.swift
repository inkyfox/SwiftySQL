//
//  SQLAlias.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

open class SQLAlias: SQLValueType, SQLSourceTableType {
    
    let sql: SQLAliasable
    let alias: String
    
    public init(_ sql: SQLAliasable, alias: String) {
        self.sql = sql
        self.alias = alias
    }
    
}

extension SQLAlias {
    
    public func `as`(_ alias: String) -> SQLAlias {
        return SQLAlias(sql, alias: alias)
    }
    
}

extension SQLAliasable {
    
    public func `as`(_ alias: String) -> SQLAlias {
        return SQLAlias(self, alias: alias)
    }
    
}

