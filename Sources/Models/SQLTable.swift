//
//  SQLTable.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLTable: SQLSourceTableType, SQLAliasable {

    public let schemaName: String?
    public let tableName: String

    public init(schemaName: String, tableName: String) {
        self.schemaName = schemaName
        self.tableName = tableName
    }
    
    public init(_ tableName: String) {
        schemaName = nil
        self.tableName = tableName
    }
    
}
