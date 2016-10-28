//
//  SQLTableGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLTableGenerator: SQLElementGenerator<SQLTable> {
    
    override func generate(_ element: SQLTable, forRead: Bool) -> String {
        if let schemaName = element.schemaName {
            return "\(schemaName).\(element.tableName)"
        } else {
            return element.tableName
        }
    }
    
}
