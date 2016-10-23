//
//  SQL.Func.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Func: SQLColumnType, SQLOrderType, SQLAliasable {
        let name: String
        let args: [SQLExprType]?
        
        public init(_ name: String, args: [SQLExprType]? = []) {
            self.name = name
            self.args = args
        }
    }

}
