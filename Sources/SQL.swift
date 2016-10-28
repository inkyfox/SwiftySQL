//
//  SQL.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQL {

    public static let null: SQLKeyword = SQLKeyword(.null)
    public static let currentDate: SQLKeyword = SQLKeyword(.currentDate)
    public static let currentTime: SQLKeyword = SQLKeyword(.currentTime)
    public static let currentTimestamp: SQLKeyword = SQLKeyword(.currentTimestamp)

    public static let all: SQLAsteriskMark = .all
    public static let prepared: SQLPreparedMark = .prepared

}


