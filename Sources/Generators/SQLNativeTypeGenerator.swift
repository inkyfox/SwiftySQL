//
//  SQLNativeTypeGenerator.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

class SQLIntGenerator: SQLElementGenerator<Int> {
    
    override func generate(_ element: Int, forRead: Bool) -> String {
        return "\(element)"
    }
    
}

class SQLFloatGenerator: SQLElementGenerator<Float> {
    
    override func generate(_ element: Float, forRead: Bool) -> String {
        return "\(element)"
    }
    
}

class SQLDoubleGenerator: SQLElementGenerator<Double> {
    
    override func generate(_ element: Double, forRead: Bool) -> String {
        return "\(element)"
    }
    
}

class SQLStringGenerator: SQLElementGenerator<String> {
    
    override func generate(_ element: String, forRead: Bool) -> String {
        return "'\(element)'"
    }
    
}

class SQLCharacterGenerator: SQLElementGenerator<Character> {
    
    override func generate(_ element: Character, forRead: Bool) -> String {
        return "'\(element)'"
    }
    
}

class SQLDateGenerator: SQLElementGenerator<Date> {
    
    override func generate(_ element: Date, forRead: Bool) -> String {
        return "\(Int64(element.timeIntervalSince1970))"
    }
    
}
