//
//  SQL.Literal.DefaultDB.swift
//  SwiftySQL
//
//  Created by indy on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL.Literal {
    
    class Generator: SQLElementGenerator<SQL.Literal> {
        
        private func keywordString(_ keyword: SQL.Literal.Keyword) -> String {
            switch keyword {
            case .null: return "NULL"
            case .currentDate: return "CURRENT_DATE"
            case .currentTime: return "CURRENT_TIME"
            case .currentTimestamp: return "CURRENT_TIMESTAMP"
            }
        }
        
        override func generate(_ element: SQL.Literal) -> String {
            
            if let keyword = element.keyword {
                return keywordString(keyword)
            } else if let number = element.number {
                return "\(number)"
            } else if let string = element.string {
                return "\"\(string)\""
            } else {
                return ""
            }
            
        }
        
    }
    
}

extension SQL.AsteriskLiteral {

    class Generator: SQLElementGenerator<SQL.AsteriskLiteral> {
        
        override func generate(_ element: SQL.AsteriskLiteral) -> String {
            return "*"
        }
        
    }
}

extension SQL.PreparedLiteral {
    
    class Generator: SQLElementGenerator<SQL.PreparedLiteral> {
        
        override func generate(_ element: SQL.PreparedLiteral) -> String {
            return "?"
        }
        
    }
    
}
