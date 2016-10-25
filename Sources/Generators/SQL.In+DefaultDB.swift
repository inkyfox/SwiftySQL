//
//  SQL.In.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.In {
    
    class Generator: SQLElementGenerator<SQL.In> {
        
        override func generate(_ element: SQL.In) -> String {
            var query = element.expr.sqlStringBoxedIfNeeded(by: generator)
            query += element.isIn ? " IN " : " NOT IN "
            query += element.table.sqlStringBoxedIfNeeded(by: generator)
            
            return query
        }
        
        override func generateFormatted(_ element: SQL.In,
                                        withIndent indent: Int) -> String {
            var query = element.expr.formattedSQLStringBoxedIfNeeded(withIndent: indent, by: generator)
            query += element.isIn ? " IN " : " NOT IN "

            let nextIndent = indent + query.characters.count
            query += element.table.formattedSQLStringBoxedIfNeeded(withIndent: nextIndent, by: generator)
            
            return query
        }
        
        
    }
    
}
