//
//  SQL.SuffixUnaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.SuffixUnaryExpr {
    
    class Generator: SQLElementGenerator<SQL.SuffixUnaryExpr> {
        
        override func generate(_ element: SQL.SuffixUnaryExpr) -> String {
            return element.lhs.sqlStringBoxedIfNeeded(by: generator) + " " + element.op
        }
        
        override func generateFormatted(_ element: SQL.SuffixUnaryExpr,
                                        withIndent indent: Int) -> String {
            return
                element.lhs.formattedSQLStringBoxedIfNeeded(withIndent: indent, by: generator) +
                " " + element.op
        }
        
    }
    
}
