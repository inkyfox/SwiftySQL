//
//  SQLTupleGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 24..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLTupleGenerator: SQLElementGenerator<SQLTuple> {
    
    override func generate(_ element: SQLTuple, forRead: Bool) -> String {
        return sqlJoin(element.exprs, forRead: forRead, by: generator).boxed
    }
    
    override func generateFormatted(_ element: SQLTuple,
                                    forRead: Bool,
                                    withIndent indent: Int) -> String {
        return formattedSQLJoinBoxed(element.exprs,
                                     forRead: forRead,
                                     withIndent: indent,
                                     by: generator)
    }
    
}
