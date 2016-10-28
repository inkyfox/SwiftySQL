//
//  SQLLimitGenerator.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLLimitGenerator: SQLElementGenerator<SQLLimit> {
    
    override func generate(_ element: SQLLimit, forRead: Bool) -> String {
        if let offset = element.offset {
            return "\(element.limit), \(offset)"
        } else {
            return "\(element.limit)"
        }
    }
    
}
