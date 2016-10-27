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
        
        override func generate(_ element: SQL.Alias, forRead: Bool) -> String {
            let name = element.sql.sqlStringBoxedIfNeeded(forRead: forRead, by: generator)
            
            if forRead {
                return name + " AS " + element.alias
            } else {
                return name
            }
        }
        
        override func generateFormatted(_ element: SQL.Alias,
                                        forRead: Bool,
                                        withIndent indent: Int) -> String {
            let name = element.sql.formattedSQLStringBoxedIfNeeded(forRead: forRead,
                                                                   withIndent: indent,
                                                                   by: generator)
            if forRead {
                return name + " AS " + element.alias
            } else {
                return name
            }
        }
        
    }
    
}
