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
    case fullQuery
    case fragment
    case queryArgs
    case queryValues
    
    func getRegex() -> String {
        switch self {
        case .scheme: return "^(http|https)://"
        case .hostname: return "(?<=@).*?(?=/)"
        case .username: return "(?<=^(http|https)://).*?(?=:)"
        case .password: return "((?<=[a-zA-Z0-9]:)(?=[a-zA-Z0-9])).*?(?=@)"
        case .path: return "(?<=[a-zA-Z0-9]/).*?(?=\\?)"
        case .fullQuery: return "(?<=\\?).*?(?=#|\\?)"
        case .fragment: return "(?<=#).*"
        case .queryArgs: return "(?<=\\?|&).*?(?=\\=)"
        case .queryValues: return "(?<=\\=).*?(?=\\&|#)"
        }
    }
    
    func getKey() -> String {
        switch self {
        case .scheme: return "scheme"
        case .hostname: return "hostname"
        case .username: return "username"
        case .password: return "password"
        case .path: return "path"
        case .fullQuery: return "query"
        case .fragment: return "fragment"
        case .queryArgs: return "key"
        case .queryValues: return "key"
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
                
                if regexTypes.contains(.queryArgs) && regexTypes.contains(.queryValues) && regexTypes.count == 2 {
                    for (index, result) in results.enumerated() {
                        //map[] = result
                    }
                    
                } else {
                    for result in results {
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
