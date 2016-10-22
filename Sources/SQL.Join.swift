//
//  SQL.Join.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 22..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension SQLSourceTableType {
    
    public func join(_ right: SQLSourceTableType, on: SQLConditionType? = nil) -> SQL.Join {
        return SQL.Join(left: self, type: .inner, right: right, on: on)
    }
    
    public func leftJoin(_ right: SQLSourceTableType, on: SQLConditionType? = nil) -> SQL.Join {
        return SQL.Join(left: self, type: .leftOuter, right: right, on: on)
    }
    
    public func leftOuterJoin(_ right: SQLSourceTableType, on: SQLConditionType? = nil) -> SQL.Join {
        return SQL.Join(left: self, type: .leftOuter, right: right, on: on)
    }
    
    public func crossJoin(_ right: SQLSourceTableType, on: SQLConditionType? = nil) -> SQL.Join {
        return SQL.Join(left: self, type: .cross, right: right, on: on)
    }

    public func naturalJoin(_ right: SQLSourceTableType, on: SQLConditionType? = nil) -> SQL.Join {
        return SQL.Join(left: self, type: .natural, right: right, on: on)
    }
    
    public func naturalLeftJoin(_ right: SQLSourceTableType, on: SQLConditionType? = nil) -> SQL.Join {
        return SQL.Join(left: self, type: .naturalLeftOuter, right: right, on: on)
    }

}

