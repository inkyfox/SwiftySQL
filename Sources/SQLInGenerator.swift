//
//  SQLInGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLInGenerator: SQLElementGenerator<SQLIn> {
    
    override func generate(_ element: SQLIn, forRead: Bool) -> String {
        var query = element.expr.sqlStringBoxedIfNeeded(forRead: forRead, by: generator)
        query += element.isIn ? " IN " : " NOT IN "
        query += element.table.sqlStringBoxedIfNeeded(forRead: forRead, by: generator)
        
        return query
    }
    
    override func generateFormatted(_ element: SQLIn,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        var query = element.expr.formattedSQLStringBoxedIfNeeded(forRead: forRead,
                                                                 withIndent: indent,
                                                                 by: generator)
        query += element.isIn ? " IN " : " NOT IN "
        
        let nextIndent = indent + query.characters.count
        query += element.table.formattedSQLStringBoxedIfNeeded(forRead: forRead,
                                                               withIndent: nextIndent,
                                                               by: generator)
        
        return query
    }
    
}
