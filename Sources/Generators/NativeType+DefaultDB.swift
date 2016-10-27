//
//  TollFreeSQLValueType+DefaultDB.swift
//  SwiftySQL
//
//  Created by Yongha Yoo (inkyfox) on 2016. 10. 25..
//  Copyright © 2016년 Gen X Hippies Company. All rights reserved.
//

import Foundation

extension Int {
    
    class Generator: SQLElementGenerator<Int> {
        
        override func generate(_ element: Int, forRead: Bool) -> String {
            return "\(element)"
        }
        
    }
    
}

extension Float {
    
    class Generator: SQLElementGenerator<Float> {
        
        override func generate(_ element: Float, forRead: Bool) -> String {
            return "\(element)"
        }
        
    }
    
}

extension Double {
    
    class Generator: SQLElementGenerator<Double> {
        
        override func generate(_ element: Double, forRead: Bool) -> String {
            return "\(element)"
        }
        
    }
    
}

extension String {
    
    class Generator: SQLElementGenerator<String> {
        
        override func generate(_ element: String, forRead: Bool) -> String {
            return "'\(element)'"
        }
        
    }
    
}

extension Character {
    
    class Generator: SQLElementGenerator<Character> {
        
        override func generate(_ element: Character, forRead: Bool) -> String {
            return "'\(element)'"
        }
        
    }
}

extension Date {
    
    class Generator: SQLElementGenerator<Date> {
        
        override func generate(_ element: Date, forRead: Bool) -> String {
            return "\(Int64(element.timeIntervalSince1970))"
        }
        
    }
}
