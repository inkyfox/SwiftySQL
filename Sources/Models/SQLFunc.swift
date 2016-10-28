//
//  SQLFunc.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLFunc: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

    let name: String
    let args: [SQLExprType]

    public init(_ name: String, args: [SQLValueType] = []) {
        self.name = name
        self.args = args
    }
    
    public init(_ name: String, args: SQLAsteriskMark) {
        self.name = name
        self.args = [args]
    }
    
    public init(_ name: String, args: SQLValueType...) {
        self.name = name
        self.args = args
    }
    
}

extension SQL {
    
    public static func count(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("COUNT", args: [arg])
    }

    public static func count(_ args: SQLAsteriskMark) -> SQLFunc {
        return SQLFunc("COUNT", args: args)
    }
    
    
}

extension SQL {
    
    public static func avg(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("AVG", args: [arg])
    }
    
    public static func max(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("MAX", args: [arg])
    }
    
    public static func min(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("MIN", args: [arg])
    }
    
    public static func sum(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("SUM", args: [arg])
    }
    
    public static func total(_ args: SQLValueType) -> SQLFunc {
        return SQLFunc("TOTAL", args: [args])
    }
    public static func abs(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("ABS", args: [arg])
    }
    
    public static func length(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("LENGTH", args: [arg])
    }

    public static func lower(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("LOWER", args: [arg])
    }

    public static func upper(_ arg: SQLValueType) -> SQLFunc {
        return SQLFunc("UPPER", args: [arg])
    }

}

