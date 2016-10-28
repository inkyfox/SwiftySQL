//
//  SQLLiteralGenerator.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLKeywordGenerator: SQLElementGenerator<SQLKeyword> {
    
    private func keywordString(_ name: SQLKeyword.Name) -> String {
        switch name {
        case .null: return "NULL"
        case .currentDate: return "CURRENT_DATE"
        case .currentTime: return "CURRENT_TIME"
        case .currentTimestamp: return "CURRENT_TIMESTAMP"
        }
    }
    
    override func generate(_ element: SQLKeyword, forRead: Bool) -> String {
        return keywordString(element.name)
    }
    
}

class SQLHexGenerator: SQLElementGenerator<SQLHex> {
    
    override func generate(_ element: SQLHex, forRead: Bool) -> String {
        if element.hex.hasPrefix("0x") {
            return element.hex
        } else {
            return "0x" + element.hex
        }
    }
    
}

class SQLAsteriskMarkGenerator: SQLElementGenerator<SQLAsteriskMark> {
    
    override func generate(_ element: SQLAsteriskMark, forRead: Bool) -> String {
        return "*"
    }
    
}

class SQLPreparedMarkGenerator: SQLElementGenerator<SQLPreparedMark> {
    
    override func generate(_ element: SQLPreparedMark, forRead: Bool) -> String {
        return "?"
    }
    
}
