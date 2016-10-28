//
//  SQLCase.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public class SQLWhenThens: SQLStringConvertible {
    
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

public struct SQLCase: SQLValueType, SQLConditionType, SQLOrderType, SQLAliasable {
    
    let whenThens: SQLWhenThens
    let defaultValue: SQLValueType?
    
    init(_ whenThens: SQLWhenThens, else defaultValue: SQLValueType? = nil) {
        self.whenThens = whenThens
        self.defaultValue = defaultValue
    }
    
}

extension SQLWhenThens {
    
    public func when(_ when: SQLConditionType, then: SQLValueType) -> SQLWhenThens {
        self.append(when: when, then: then)
        return self
    }
    
    public func `else`(_ defaultValue: SQLValueType) -> SQLCase {
        return SQLCase(self, else: defaultValue)
    }
    
}

public func when(_ when: SQLConditionType, then: SQLValueType) -> SQLWhenThens {
    return SQLWhenThens(when: when, then: then)
}

extension Array where Element : SQLWhenThens {
    
    public func `else`(_ defaultValue: SQLValueType) -> SQLCase {
        return SQLCase(SQLWhenThens(self.reduce([]) { $0 + $1.whenThens }),
                       else: defaultValue)
    }
    
}

//infix operator => : TernaryPrecedence
//
//public func =>(lhs: SQLConditionType, rhs: SQLValueType) -> SQLWhenThen {
//    return SQLWhenThens(when: lhs, then: rhs)
//}

