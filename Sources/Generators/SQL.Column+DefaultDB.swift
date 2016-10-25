//
//  SQL.Column+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Column {
    
    class Generator: SQLElementGenerator<SQL.Column> {
        
        override func generate(_ element: SQL.Column) -> String {
            if let t = element.tableName {
                return "\(t).\(element.columnName)"
            } else {
                return element.columnName
            }
        }
        
    }
}
