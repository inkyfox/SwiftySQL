//
//  SQLType.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public protocol SQLExprType: SQLStringConvertible { }
public protocol SQLColumnType: SQLExprType { }
public protocol SQLConditionType: SQLExprType { }

public protocol SQLSourceTableType: SQLStringConvertible { }
public protocol SQLOrderType: SQLStringConvertible { }

public protocol SQLAliasable: SQLStringConvertible { }


public protocol SQLQueryType: SQLStringConvertible {

    func query(by generator: SQLGenerator) -> String
    
    func formattedQuery(by generator: SQLGenerator) -> String

}
