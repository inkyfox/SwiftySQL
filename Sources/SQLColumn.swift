//
//  SQLColumn.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLColumn: SQLValueType, SQLOrderType, SQLConditionType, SQLAliasable {

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

extension SQLColumn {
    
    public func of(_ table: SQLAlias) -> SQLColumn {
        return SQLColumn(table: table.alias, column: columnName)
    }
    
    public func of(_ table: String) -> SQLColumn {
        return SQLColumn(table: table, column: columnName)
    }

}
