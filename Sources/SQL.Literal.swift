//
//  SQL.Literal.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 23..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQL {
    
    public struct Literal: SQLColumnType, SQLAliasable {
        
        public static let null: Literal = Literal(.null)
        public static let currentDate: Literal = Literal(.currentDate)
        public static let currentTime: Literal = Literal(.currentTime)
        public static let currentTimestamp: Literal = Literal(.currentTimestamp)
        
        public enum Keyword {
            case null, currentDate, currentTime, currentTimestamp
        }
        
        let keyword: Keyword?
        let number: TollFreeSQLColumnType?
        let string: String?
        
        init(_ keyword: Keyword) {
            self.keyword = keyword
            self.number = nil
            self.string = nil
        }
        
        init(_ number: TollFreeSQLColumnType) {
            self.keyword = nil
            self.number = number
            self.string = nil
        }
        
        init(_ string: String) {
            self.keyword = nil
            self.number = nil
            self.string = string
        }
        
    }
    
    public enum AsteriskLiteral: SQLExprType {
        case all
    }

    public enum PreparedLiteral: SQLExprType {
        case prepared
    }
}

