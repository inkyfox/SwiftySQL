//
//  SQLBinaryExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLBinaryExpr: SQLOperaorExprType, SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

    let lhs: SQLExprType
    let op: String
    let rhs: SQLExprType
    
    public init(_ lhs: SQLExprType, _ op: String, _ rhs: SQLExprType) {
        self.lhs = lhs
        self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
        self.rhs = rhs
    }

}

public func ==(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<>", rhs)
}

public func &&(lhs: SQLConditionType, rhs: SQLConditionType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "AND", rhs)
}

public func ||(lhs: SQLConditionType, rhs: SQLConditionType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "OR", rhs)
}

public func +(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<<", rhs)
}

extension SQLValueType {
    
    public func `is`(_ expr: SQLValueType) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "IS", expr)
    }
    
    public func isNot(_ expr: SQLValueType) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "IS NOT", expr)
    }
    
    public func concat(_ expr: SQLValueType) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "||", expr)
    }
    
}

extension SQLValueType {

    public func like(_ pattern: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "LIKE", pattern)
    }
    
    public func notLike(_ pattern: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "NOT LIKE", pattern)
    }
 
    public func likeIgnoreCase(_ pattern: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE", SQL.upper(pattern))
    }
    
    public func notLikeIgnoreCase(_ pattern: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "NOT LIKE", SQL.upper(pattern))
    }
    
    public func contains(_ substring: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "LIKE", "%\(substring)%")
    }
    
    public func hasPrefix(_ prefix: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "LIKE", "\(prefix)%")
    }
    
    public func hasSuffix(_ suffix: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "LIKE", "%\(suffix)")
    }
    
    public func containsIgnoreCase(_ substring: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE", SQL.upper("%\(substring)%"))
    }
    
    public func hasPrefixIgnoreCase(_ prefix: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE", SQL.upper("\(prefix)%"))
    }
    
    public func hasSuffixIgnoreCase(_ suffix: String) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE", SQL.upper("%\(suffix)"))
    }
    
}

public func ==(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<>", rhs)
}

public func +(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<<", rhs)
}

public func ==(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<>", rhs)
}

public func +(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<<", rhs)
}

public func ==(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<>", rhs)
}

public func +(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
    return SQLBinaryExpr(lhs, "<<", rhs)
}

extension SQLValueType {
    
    public func `is`(_ rhs: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "IS", rhs)
    }
    
    public func isNot(_ rhs: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "IS NOT", rhs)
    }
    
    public func concat(_ rhs: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "||", rhs)
    }
    
}

extension SQLPreparedMark {
    
    public func concat(_ expr: SQLValueType) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "||", expr)
    }
    
}


extension SQLValueType {
    
    public func like(_ rhs: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "LIKE", rhs)
    }
    
    public func notLike(_ rhs: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(self, "NOT LIKE", rhs)
    }
    
    public func containsIgnoreCase(_ substring: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE",
                              SQL.upper("%".concat(SQL.prepared).concat("%")))
    }
    
    public func hasPrefixIgnoreCase(_ prefix: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE",
                              SQL.upper(SQL.prepared.concat("%")))
    }
    
    public func hasSuffixIgnoreCase(_ suffix: SQLPreparedMark) -> SQLBinaryExpr {
        return SQLBinaryExpr(SQL.upper(self), "LIKE",
                              SQL.upper("%".concat(SQL.prepared)))
    }
    
}


////

//infix operator <> : ComparisonPrecedence
//
//public func <>(lhs: SQLValueType, rhs: SQLValueType) -> SQLBinaryExpr {
//    return SQLBinaryExpr(lhs, "<>", rhs)
//}
//
//public func <>(lhs: SQLValueType, rhs: SQLPreparedMark) -> SQLBinaryExpr {
//    return SQLBinaryExpr(lhs, "<>", rhs)
//}
//
//public func <>(lhs: SQLPreparedMark, rhs: SQLValueType) -> SQLBinaryExpr {
//    return SQLBinaryExpr(lhs, "<>", rhs)
//}
//
//
//public func <>(lhs: SQLPreparedMark, rhs: SQLPreparedMark) -> SQLBinaryExpr {
//    return SQLBinaryExpr(lhs, "<>", rhs)
//}
