//
//  SQLLiteral.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQLKeyword: SQLValueType, SQLAliasable {

    enum Name {
        case null, currentDate, currentTime, currentTimestamp
    }
    
    let name: Name

    init(_ name: Name) {
        self.name = name
    }
    
}

public struct SQLHex: SQLValueType, SQLAliasable {
    
    let hex: String

    public init(_ value: Int) {
        self.hex = String(format: "0x%X", value)
    }
    
}


public enum SQLAsteriskMark: SQLExprType {
    case all
}

public enum SQLPreparedMark: SQLExprType {
    case prepared
}
