//
//  SQL.Literal.DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Keyword {
    
    class Generator: SQLElementGenerator<SQL.Keyword> {
        
        private func keywordString(_ name: SQL.Keyword.Name) -> String {
            switch name {
            case .null: return "NULL"
            case .currentDate: return "CURRENT_DATE"
            case .currentTime: return "CURRENT_TIME"
            case .currentTimestamp: return "CURRENT_TIMESTAMP"
            }
        }
        
        override func generate(_ element: SQL.Keyword) -> String {
            return keywordString(element.name)
        }
        
    }
    
}

extension SQL.Hex {
    
    class Generator: SQLElementGenerator<SQL.Hex> {
        
        override func generate(_ element: SQL.Hex) -> String {
            if element.hex.hasPrefix("0x") {
                return element.hex
            } else {
                return "0x" + element.hex
            }
        }
        
    }
    
}

extension SQL.AsteriskMark {

    class Generator: SQLElementGenerator<SQL.AsteriskMark> {
        
        override func generate(_ element: SQL.AsteriskMark) -> String {
            return "*"
        }
        
    }
}

extension SQL.PreparedMark {
    
    class Generator: SQLElementGenerator<SQL.PreparedMark> {
        
        override func generate(_ element: SQL.PreparedMark) -> String {
            return "?"
        }
        
    }
    
}
