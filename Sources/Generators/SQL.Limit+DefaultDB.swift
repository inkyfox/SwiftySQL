//
//  SQL.Limit+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Limit {
    
    class Generator: SQLElementGenerator<SQL.Limit> {
        
        override func generate(_ element: SQL.Limit, forRead: Bool) -> String {
            if let offset = element.offset {
                return "\(element.limit), \(offset)"
            } else {
                return "\(element.limit)"
            }
        }
        
    }

}
