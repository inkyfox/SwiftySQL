//
//  SQL.Alias+DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Alias {
    
    class Generator: SQLElementGenerator<SQL.Alias> {
        
        override func generate(_ element: SQL.Alias) -> String {
            return element.sql.sqlStringBoxedIfNeeded(by: generator) + " AS " + element.alias
        }
        
        override func generateFormatted(_ element: SQL.Alias,
                                        withIndent indent: Int) -> String {
            return
                element.sql.formattedSQLStringBoxedIfNeeded(withIndent: indent, by: generator) +
                    " AS " + element.alias
        }
        
    }
    
}
