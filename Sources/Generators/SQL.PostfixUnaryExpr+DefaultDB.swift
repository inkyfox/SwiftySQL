//
//  SQL.PostfixUnaryExpr+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.PostfixUnaryExpr {
    
    class Generator: SQLElementGenerator<SQL.PostfixUnaryExpr> {
        
        override func generate(_ element: SQL.PostfixUnaryExpr) -> String {
            return element.lhs.sqlStringBoxedIfNeeded(by: generator) + " " + element.op
        }
        
        override func generateFormatted(_ element: SQL.PostfixUnaryExpr,
                                        withIndent indent: Int) -> String {
            return
                element.lhs.formattedSQLStringBoxedIfNeeded(withIndent: indent, by: generator) +
                " " + element.op
        }
        
    }
    
}
