//
//  UrlParser.swift
//  UrlParser
//
//  Created by Christopher Eliasson on 2017-03-16.
//  Copyright © 2017 Christopher Eliasson. All rights reserved.
//

import Foundation


enum ParseRegex {
    case scheme
    case hostname
    case username
    case password
    case path
    case query
    case fragment
    
    func regex() -> String {
        switch self {
        case .scheme: return "^(http|https)://"
        case .hostname: return "(?<=@).*?(?=/)"
        case .username: return "(?<=^(http|https)://).*?(?=:)"
        case .password: return "((?<=[a-zA-Z0-9]:)(?=[a-zA-Z0-9])).*?(?=@)"
        case .path: return "(?<=[a-zA-Z0-9]/).*?(?=\\?)"
        case .query: return "(?<=\\?).*?(?=#|\\?)"
        case .fragment: return "(?<=#).*"
        }
    }
}

class UrlParser {
    static let shared = UrlParser()
    
    
    func parse(regex: ParseRegex) {
        
        let test: ParseRegex = .fragment
        do {
            let regex2 = try NSRegularExpression(pattern: test.regex())
            let string = "http://username:password@hostname/path?arg=value?arg=value2#anchor"
            
            let matches = regex2.matches(in: string, options: [], range: NSRange(location: 0, length: string.characters.count))
            
            let results = matches.map { match -> String in
                let range = match.rangeAt(0)
                let start = String.UTF16Index(range.location)
                let end = String.UTF16Index(range.location + range.length)
                
                return String(string.utf16[start..<end])!
            }
            
            var tests = 0
        
        } catch let error {
            debugPrint("invalid regex: " + error.localizedDescription)
        }
    }
}
