//
//  SQL.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

public struct SQL {

    public static let null: Keyword = Keyword(.null)
    public static let currentDate: Keyword = Keyword(.currentDate)
    public static let currentTime: Keyword = Keyword(.currentTime)
    public static let currentTimestamp: Keyword = Keyword(.currentTimestamp)

    public static let all: AsteriskMark = .all
    public static let prepared: PreparedMark = .prepared

}


