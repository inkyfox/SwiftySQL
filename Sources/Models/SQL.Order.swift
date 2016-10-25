//
//  SQL.Order.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Order: SQLOrderType {
        
        public enum Sort {
            case asc, desc
        }
        
        let column: SQLValueType
        let sort: Sort
        
    }
    
}

extension SQLValueType {
    
    public var asc: SQL.Order {
        return SQL.Order(column: self, sort: .asc)
    }
    
    public var desc: SQL.Order {
        return SQL.Order(column: self, sort: .desc)
    }
}


