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
    case extractedQuery
    case fragment
    
    
    func getRegex() -> String {
        switch self {
        case .scheme: return "^(http|https)://"
        case .hostname: return "(?<=@).*?(?=/)"
        case .username: return "(?<=^(http|https)://).*?(?=:)"
        case .password: return "((?<=[a-zA-Z0-9]:)(?=[a-zA-Z0-9])).*?(?=@)" // Note: This regex will only fetch password if username is a-z, A-Z, 0-9 even though the regex for .username allows username to be all characters. Password can also only be a-z, A-Z, and 0-9.
        case .path: return "(?<=[a-zA-Z0-9]/).*?(?=\\?)"
        case .query: return "(?<=\\?).*?(?=#|\\?)"
        case .fragment: return "(?<=#).*"
        case .extractedQuery: return "(?<=\\?|\\&).*?(?=#|\\&)"
    
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
        case .extractedQuery: return ""

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
                    
                    if type == .extractedQuery {
                        
                        // The regex for extractedQuery will extract arg=value, we will then split it based on "=" and use the first string as key and the next as value. Quickest and easiest solution I could think of, but also stinky.
                        
                        let splitResult = result.components(separatedBy: "=")
                        
                        if splitResult.count > 1 {
                            map[splitResult[0]] = splitResult[1]
                        }

                    } else {
                        map[type.getKey()] = result
                    }
                    
                }
                
                
            } catch let error {
                debugPrint("invalid regex: " + error.localizedDescription)
            }
        }
        
        return map
    }
}
