//
//  SQL.Func.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Func: SQLColumnType, SQLConditionType, SQLOrderType, SQLAliasable {
        let name: String
        let args: [SQLExprType]
        
        public init(_ name: String, args: [SQLExprType] = []) {
            self.name = name
            self.args = args
        }

        public init(_ name: String, arg: SQL.Literal) {
            self.name = name
            self.args = [arg]
        }
}

}

extension SQL {
    
    public static func avg(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("AVG", args: [arg])
    }
    
    public static func count(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("COUNT", args: [arg])
    }

    public static func count(_ arg: SQL.Literal) -> SQL.Func {
        return SQL.Func("COUNT", arg: arg)
    }
    
    public static func max(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("MAX", args: [arg])
    }
    
    public static func min(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("MIN", args: [arg])
    }
    
    public static func sum(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("SUM", args: [arg])
    }
    
    public static func total(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("TOTAL", args: [arg])
    }
    
}

extension SQL {

    public static func abs(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("ABS", args: [arg])
    }
    
    public static func length(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("LENGTH", args: [arg])
    }

    public static func lower(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("LOWER", args: [arg])
    }

    public static func upper(_ arg: SQLExprType) -> SQL.Func {
        return SQL.Func("UPPER", args: [arg])
    }

}

