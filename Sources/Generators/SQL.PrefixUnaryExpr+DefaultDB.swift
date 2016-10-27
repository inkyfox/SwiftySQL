//
//  SQL.PrefixUnaryExpr.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

private let trimmedUnaryOperators = Set<String>(["+", "-", "~"])

extension SQL.PrefixUnaryExpr {
    
    class Generator: SQLElementGenerator<SQL.PrefixUnaryExpr> {
        
        override func generate(_ element: SQL.PrefixUnaryExpr, forRead: Bool) -> String {
            
            var query = element.op
            
            if !trimmedUnaryOperators.contains(element.op) {
                query += " "
            }
            
            query += element.rhs.sqlStringBoxedIfNeeded(forRead: forRead, by: generator)
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.PrefixUnaryExpr,
                                        forRead: Bool,
                                        withIndent indent: Int) -> String {
            var query = "\(element.op)"
            
            var nextIndent = indent + query.characters.count
            
            if !trimmedUnaryOperators.contains(element.op) {
                query += " "
                nextIndent += 1
            }
            
            query += element.rhs.formattedSQLStringBoxedIfNeeded(forRead: forRead,
                                                                 withIndent: nextIndent,
                                                                 by: generator)
            
            return query
        }
        
        
    }
    
}

