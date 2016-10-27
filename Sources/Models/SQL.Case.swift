//
//  SQL.Case.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public class WhenThens: SQLStringConvertible {
        
        var whenThens: [(when:  SQLConditionType, then: SQLValueType)]
        
        init(_ whenThens: [(when:  SQLConditionType, then: SQLValueType)]) {
            self.whenThens = whenThens
        }

        init(when: SQLConditionType, then: SQLValueType) {
            whenThens = [(when, then)]
        }

        func append(when: SQLConditionType, then: SQLValueType) {
            whenThens.append((when, then))
        }
        
    }

    public struct Case: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {
        
        let whenThens: WhenThens
        let defaultValue: SQLValueType?
        
        init(_ whenThens: WhenThens, else defaultValue: SQLValueType? = nil) {
            self.whenThens = whenThens
            self.defaultValue = defaultValue
        }

    }
    
}

extension SQL.WhenThens {
    
    public func when(_ when: SQLConditionType, then: SQLValueType) -> SQL.WhenThens {
        self.append(when: when, then: then)
        return self
    }

    public func `else`(_ defaultValue: SQLValueType) -> SQL.Case {
        return SQL.Case(self, else: defaultValue)
    }
    
}

public func when(_ when: SQLConditionType, then: SQLValueType) -> SQL.WhenThens {
    return SQL.WhenThens(when: when, then: then)
}

extension Array where Element : SQL.WhenThens {
    
    public func `else`(_ defaultValue: SQLValueType) -> SQL.Case {
        return SQL.Case(SQL.WhenThens(self.reduce([]) { $0 + $1.whenThens }),
                        else: defaultValue)
    }

}

//infix operator => : TernaryPrecedence
//
//public func =>(lhs: SQLConditionType, rhs: SQLValueType) -> SQL.WhenThen {
//    return SQL.WhenThens(when: lhs, then: rhs)
//}

