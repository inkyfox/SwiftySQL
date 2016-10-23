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
            case .asterisk: return "*"
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
        
        override func generateFormatted(_ element: SQL.Literal,
                                        withIndent indent: Int) -> String {
            return generate(element)
        }
        
    }
    
}
