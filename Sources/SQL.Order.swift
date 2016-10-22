//
//  SQL.Order.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQLColumnType {
    
    public var asc: SQL.Order {
        return SQL.Order(column: self, sort: .asc)
    }
    
    public var desc: SQL.Order {
        return SQL.Order(column: self, sort: .desc)
    }
}

