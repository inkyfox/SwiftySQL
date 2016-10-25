//
//  SQLType.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public protocol SQLExprType: SQLStringConvertible { }
public protocol SQLValueType: SQLExprType { }
public protocol SQLConditionType: SQLExprType { }
public protocol SQLOperaorExprType: SQLExprType { }

public protocol SQLSourceTableType: SQLStringConvertible { }
public protocol SQLOrderType: SQLStringConvertible { }

public protocol SQLAliasable: SQLStringConvertible { }


public protocol SQLQueryType: SQLStringConvertible {

    func query(by generator: SQLGenerator) -> String
    
    func formattedQuery(withIndent indent: Int, by generator: SQLGenerator) -> String

}

public protocol SQLNumberType: SQLValueType, SQLAliasable, SQLConditionType { }

extension Int: SQLNumberType { }

extension Float: SQLNumberType { }

extension Double: SQLNumberType { }

extension String: SQLValueType, SQLAliasable { }

extension Character: SQLValueType, SQLAliasable { }

extension Date: SQLValueType, SQLAliasable { }
