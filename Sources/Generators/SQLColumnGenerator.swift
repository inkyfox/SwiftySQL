//
//  SQLColumnGenerator.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLColumnGenerator: SQLElementGenerator<SQLColumn> {
    
    override func generate(_ element: SQLColumn, forRead: Bool) -> String {
        if let t = element.tableName, forRead {
            return "\(t).\(element.columnName)"
        } else {
            return element.columnName
        }
    }
    
}
