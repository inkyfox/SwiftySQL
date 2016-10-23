//
//  SQL.Table.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Table: SQLSourceTableType, SQLAliasable {
        public let table: String
        
        public init(_ table: String) {
            self.table = table
        }
    }

}
