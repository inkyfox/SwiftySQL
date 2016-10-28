//
//  SQLOrderGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLOrderGenerator: SQLElementGenerator<SQLOrder> {
    
    func sortString(_ sort: SQLOrder.Sort) -> String {
        switch sort {
        case .asc: return "ASC"
        case .desc:  return "DESC"
        }
    }
    
    override func generate(_ element: SQLOrder, forRead: Bool) -> String {
        return element.column.sqlString(forRead: forRead, by: generator)
            + " " + sortString(element.sort)
    }
    
    override func generateFormatted(_ element: SQLOrder,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        return element.column.formattedSQLString(forRead: forRead,
                                                 withIndent: indent,
                                                 by: generator)
            + " " + sortString(element.sort)
    }
    
}
