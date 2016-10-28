import Foundation
import SwiftySQL

extension String {
    func replacingOccurrences(of regex: NSRegularExpression, with to: String) -> String {
        return regex.stringByReplacingMatches(in: self, options: [], range: NSRange(location: 0, length: characters.count),
                                              withTemplate: to)
    }
}

extension Date {
    static func of(_ yyyymmdd: String) -> Date {
        let f = DateFormatter()
        f.dateFormat = "yyyyMMdd"
        return f.date(from: yyyymmdd)!
    }
}

func unformat(_ query: String) -> String {
    return
        query.components(separatedBy: "\n")
            .map { $0.trimmingCharacters(in: CharacterSet.whitespaces) }
            .joined(separator: " ")
            .replacingOccurrences(of: " FROM   ", with: " FROM ")
            .replacingOccurrences(of: " GROUP  BY ", with: " GROUP BY ")
            .replacingOccurrences(of: " ORDER  BY ", with: " ORDER BY ")
            .replacingOccurrences(of: " LIMIT  ", with: " LIMIT ")
            .replacingOccurrences(of: try! NSRegularExpression(pattern: " WHERE [ ]*", options: .caseInsensitive),
                                  with: " WHERE ")
            .replacingOccurrences(of: try! NSRegularExpression(pattern: " VALUES [ ]*", options: .caseInsensitive),
                                  with: " VALUES ")
            .replacingOccurrences(of: try! NSRegularExpression(pattern: " SET [ ]*", options: .caseInsensitive),
                                  with: " SET ")
            .replacingOccurrences(of: "( ", with: "(")
            .replacingOccurrences(of: " )", with: ")")
}

extension SQLStringConvertible {
    func sql(by generator: SQLGenerator) -> String {
        return (self as? SQLQueryType)?.query(by: generator) ??
            self.sqlString(forRead: true, by: generator)
    }
    
    func formattedSQL(withIndent indent: Int, by generator: SQLGenerator) -> String {
        return (self as? SQLQueryType)?.formattedQuery(withIndent: indent,
                                                       by: generator) ??
            self.formattedSQLString(forRead: true,
                                    withIndent: indent,
                                    by: generator)
    }
}


public func checkSQL(_ sql: SQLStringConvertible) {
    let generator = SQLGenerator.default
    let query = sql.sql(by: generator)
    let formatted = sql.formattedSQL(withIndent: 0, by: generator)
    let passed = query == unformat(formatted)
    let result = passed ? "[Passed] " : "[Failed] "
    let indent = result.characters.count
    if passed {
        print("\(result)\(sql.formattedSQL(withIndent: indent, by: generator))")
    } else {
        print("\(result)\(sql.formattedSQL(withIndent: indent, by: generator))")
        print("    \(query)")
        print("    \(unformat(formatted))")
    }
}
