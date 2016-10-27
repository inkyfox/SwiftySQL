//
//  SQL.OpExpr.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct BinaryExpr: SQLOperaorExprType, SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {

        let lhs: SQLExprType
        let op: String
        let rhs: SQLExprType
        
        public init(_ lhs: SQLExprType, _ op: String, _ rhs: SQLExprType) {
            self.lhs = lhs
            self.op = op.trimmingCharacters(in: whiteSpaces).uppercased()
            self.rhs = rhs
        }

    }
    
}

public func ==(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<>", rhs)
}

public func &&(lhs: SQLConditionType, rhs: SQLConditionType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "AND", rhs)
}

public func ||(lhs: SQLConditionType, rhs: SQLConditionType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "OR", rhs)
}

public func +(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<<", rhs)
}

extension SQLValueType {
    
    public func `is`(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS", expr)
    }
    
    public func isNot(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS NOT", expr)
    }
    
    public func concat(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", expr)
    }
    
}

extension SQLValueType {

    public func like(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", pattern)
    }
    
    public func notLike(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "NOT LIKE", pattern)
    }
 
    public func likeIgnoreCase(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper(pattern))
    }
    
    public func notLikeIgnoreCase(_ pattern: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "NOT LIKE", SQL.upper(pattern))
    }
    
    public func contains(_ substring: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "%\(substring)%")
    }
    
    public func hasPrefix(_ prefix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "\(prefix)%")
    }
    
    public func hasSuffix(_ suffix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", "%\(suffix)")
    }
    
    public func containsIgnoreCase(_ substring: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper("%\(substring)%"))
    }
    
    public func hasPrefixIgnoreCase(_ prefix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper("\(prefix)%"))
    }
    
    public func hasSuffixIgnoreCase(_ suffix: String) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE", SQL.upper("%\(suffix)"))
    }
    
}

public func ==(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<>", rhs)
}

public func +(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<<", rhs)
}

public func ==(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<>", rhs)
}

public func +(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<<", rhs)
}

public func ==(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "=", rhs)
}

public func >(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">", rhs)
}

public func >=(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">=", rhs)
}

public func <(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<", rhs)
}

public func <=(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<=", rhs)
}

public func !=(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<>", rhs)
}

public func +(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "+", rhs)
}

public func -(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "-", rhs)
}

public func *(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "*", rhs)
}

public func /(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "/", rhs)
}

public func %(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "%", rhs)
}

public func &(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "&", rhs)
}

public func |(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "|", rhs)
}

public func >>(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, ">>", rhs)
}

public func <<(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
    return SQL.BinaryExpr(lhs, "<<", rhs)
}

extension SQLValueType {
    
    public func `is`(_ rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS", rhs)
    }
    
    public func isNot(_ rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "IS NOT", rhs)
    }
    
    public func concat(_ rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", rhs)
    }
    
}

extension SQL.PreparedMark {
    
    public func concat(_ expr: SQLValueType) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "||", expr)
    }
    
}


extension SQLValueType {
    
    public func like(_ rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "LIKE", rhs)
    }
    
    public func notLike(_ rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(self, "NOT LIKE", rhs)
    }
    
    public func containsIgnoreCase(_ substring: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE",
                              SQL.upper("%".concat(SQL.prepared).concat("%")))
    }
    
    public func hasPrefixIgnoreCase(_ prefix: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE",
                              SQL.upper(SQL.prepared.concat("%")))
    }
    
    public func hasSuffixIgnoreCase(_ suffix: SQL.PreparedMark) -> SQL.BinaryExpr {
        return SQL.BinaryExpr(SQL.upper(self), "LIKE",
                              SQL.upper("%".concat(SQL.prepared)))
    }
    
}


////

//infix operator <> : ComparisonPrecedence
//
//public func <>(lhs: SQLValueType, rhs: SQLValueType) -> SQL.BinaryExpr {
//    return SQL.BinaryExpr(lhs, "<>", rhs)
//}
//
//public func <>(lhs: SQLValueType, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
//    return SQL.BinaryExpr(lhs, "<>", rhs)
//}
//
//public func <>(lhs: SQL.PreparedMark, rhs: SQLValueType) -> SQL.BinaryExpr {
//    return SQL.BinaryExpr(lhs, "<>", rhs)
//}
//
//
//public func <>(lhs: SQL.PreparedMark, rhs: SQL.PreparedMark) -> SQL.BinaryExpr {
//    return SQL.BinaryExpr(lhs, "<>", rhs)
//}
