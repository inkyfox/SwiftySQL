//
//  SQL.Column.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Column: SQLValueType, SQLOrderType, SQLConditionType, SQLAliasable {
        let tableName: String?
        let columnName: String
        
        public init(table: String, column: String) {
            tableName = table
            columnName = column
        }
        
        public init(_ column: String) {
            tableName = nil
            columnName = column
        }
        
    }
    
}

extension SQL.Column {
    
    public func of(_ table: SQL.Alias) -> SQL.Column {
        return SQL.Column(table: table.alias, column: columnName)
    }
    
    public func of(_ table: String) -> SQL.Column {
        return SQL.Column(table: table, column: columnName)
    }

}
