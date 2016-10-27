//
//  SQL.Func.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Func: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {
        let name: String
        let args: [SQLExprType]
        
        public init(_ name: String, args: [SQLValueType] = []) {
            self.name = name
            self.args = args
        }

        public init(_ name: String, args: SQL.AsteriskMark) {
            self.name = name
            self.args = [args]
        }
        
        public init(_ name: String, args: SQLValueType...) {
            self.name = name
            self.args = args
        }
        
    }

}

extension SQL {
    
    public static func count(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("COUNT", args: [arg])
    }

    public static func count(_ args: SQL.AsteriskMark) -> SQL.Func {
        return SQL.Func("COUNT", args: args)
    }
    
    
}

extension SQL {
    
    public static func avg(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("AVG", args: [arg])
    }
    
    public static func max(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("MAX", args: [arg])
    }
    
    public static func min(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("MIN", args: [arg])
    }
    
    public static func sum(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("SUM", args: [arg])
    }
    
    public static func total(_ args: SQLValueType) -> SQL.Func {
        return SQL.Func("TOTAL", args: [args])
    }
    public static func abs(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("ABS", args: [arg])
    }
    
    public static func length(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("LENGTH", args: [arg])
    }

    public static func lower(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("LOWER", args: [arg])
    }

    public static func upper(_ arg: SQLValueType) -> SQL.Func {
        return SQL.Func("UPPER", args: [arg])
    }

}

