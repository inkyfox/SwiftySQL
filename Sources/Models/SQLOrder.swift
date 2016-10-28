//
//  SQLOrder.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLOrder: SQLOrderType {
    
    public enum Sort {
        case asc, desc
    }
    
    let column: SQLValueType
    let sort: Sort

}

extension SQLValueType {
    
    public var asc: SQLOrder {
        return SQLOrder(column: self, sort: .asc)
    }
    
    public var desc: SQLOrder {
        return SQLOrder(column: self, sort: .desc)
    }
}


