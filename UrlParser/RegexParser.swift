//
//  RegexParser.swift
//  RegexParser
//
//  Created by Christopher Eliasson on 2017-03-16.
//  Copyright © 2017 Christopher Eliasson. All rights reserved.
//

import Foundation


enum RegexType {
    case scheme
    case hostname
    case username
    case password
    case path
    case query
    case fragment
    
    func getRegex() -> String {
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
    
    func getKey() -> String {
        switch self {
        case .scheme: return "scheme"
        case .hostname: return "hostname"
        case .username: return "username"
        case .password: return "password"
        case .path: return "path"
        case .query: return "query"
        case .fragment: return "fragment"
        }
    }
}

class RegexParser {
    static let shared = RegexParser()
    
    
    func parse(text: String, with regexTypes: [RegexType]) -> [String:String] {
        
        var map: [String:String] = [:]
        for type in regexTypes {
            
            do {
                let regex = try NSRegularExpression(pattern: type.getRegex())
                
                let matches = regex.matches(in: text, options: [], range: NSRange(location: 0, length: text.characters.count))
                
                let results = matches.map { match -> String in
                    let range = match.rangeAt(0)
                    let start = String.UTF16Index(range.location)
                    let end = String.UTF16Index(range.location + range.length)
                    
                    return String(text.utf16[start..<end])!
                }
                
                for result in results {
                    map[type.getKey()] = result
                }
                
            } catch let error {
                debugPrint("invalid regex: " + error.localizedDescription)
            }
        }
        
        return map
    }
}
