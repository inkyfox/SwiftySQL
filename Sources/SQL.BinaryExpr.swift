//
//  SQL.BinaryExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQLColumnType {
    
    public func eq(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "=", expr)
    }
    
    public func gt(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">", expr)
    }
    
    public func ge(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, ">=", expr)
    }
    
    public func lt(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<", expr)
    }
    
    public func le(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<=", expr)
    }
    
    public func ne(_ expr: SQLColumnType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "<>", expr)
    }
    
}

extension SQLConditionType {
    
    public func and(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "AND", expr)
    }
    
    public func or(_ expr: SQLConditionType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "OR", expr)
    }
    
    
    
}

