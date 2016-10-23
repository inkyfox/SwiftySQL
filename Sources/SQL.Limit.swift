//
//  SQL.Limit.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Limit: SQLStringConvertible {
        let limit: UInt
        let offset: UInt?
    }

}
