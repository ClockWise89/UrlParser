//
//  ViewController.swift
//  UrlParser
//
//  Created by Christopher Eliasson on 2017-03-16.
//  Copyright © 2017 Christopher Eliasson. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let baseUrl = "http://username:password@hostname/path?arg=value&arg2=value2#anchor"
        
        let regexForUrl: [RegexType] = [.scheme, .hostname, .username, .password, .path, .fragment, .query, .extractedQuery]
        let map = RegexParser.shared.parse(text: baseUrl, with: regexForUrl)
        map.forEach{
            print("----------------")
            print("Key: \($0.key)")
            print("Value: \($0.value)")
            print("----------------")
            print("")
        }
        
        
    }
}

