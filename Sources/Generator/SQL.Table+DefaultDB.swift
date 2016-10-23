//
//  SQL.Table+DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Table {

    class Generator: SQLElementGenerator<SQL.Table> {
        
        override func generate(_ element: SQL.Table) -> String {
            return element.table
        }
        
    }
}
