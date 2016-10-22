//
//  SQLUtils.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 21..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation


internal let whiteSpaces = CharacterSet.whitespacesAndNewlines

extension String {

    var needParentheses: Bool {
        return rangeOfCharacter(from: whiteSpaces) != nil && !(hasPrefix("(") && hasSuffix(")"))
    }
    
    var parenthesesIfNeeded: String {
        return needParentheses ? "(\(self))" : self
    }
}

private var indentSpaces: [Int : String] = [:]

internal func space(_ indent: Int) -> String {
    if let space = indentSpaces[indent] { return space }
    
    let space = String(repeating: " ", count: indent)
    indentSpaces[indent] = space
    return space
}
