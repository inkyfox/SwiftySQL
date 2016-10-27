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
        
        override func generate(_ element: SQL.PostfixUnaryExpr, forRead: Bool) -> String {
            return element.lhs.sqlStringBoxedIfNeeded(forRead: forRead, by: generator) + " " + element.op
        }
        
        override func generateFormatted(_ element: SQL.PostfixUnaryExpr,
                                        forRead: Bool,
                                        withIndent indent: Int) -> String {
            return
                element.lhs.formattedSQLStringBoxedIfNeeded(forRead: forRead,
                                                            withIndent: indent,
                                                            by: generator) +
                " " + element.op
        }
        
    }
    
}
